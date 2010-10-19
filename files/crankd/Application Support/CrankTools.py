#!/usr/bin/python2.5
#
#	CrankTools.py
#		The OnNetworkLoad method is called from crankd on a network state change, all other
#			methods assist it. In the future, I will add other "On..." methods to respond 
#			to other state changes.
#
#	Last Revised - 10/12/2010

__author__ = 'Gary Larizza (gary@huronhs.com)'
__version__ = '0.1'

import sys
sys.path.append('/Library/HuronHS/Python2.5')
import pymacds
import syslog
import subprocess
import os
import socket
from time import sleep
from SystemConfiguration import *

syslog.openlog("CrankD")
_PUPPETD = '/usr/bin/puppetd.rb'

class CrankTools():
	"""The main CrankTools class needed for our crankd config plist"""
	
	def puppetRun(self):
		"""Checks for an active network connection and calls puppet if it finds one.  
			If the network is NOT active, it logs an error and exits
		---
		Arguments: None
		Returns:  Nothing
		"""
		if not self.LinkState('en1'):
			self.callPuppet()
		elif not self.LinkState('en0'):
			self.callPuppet()
		else:
			syslog.syslog(syslog.LOG_ALERT, "Internet Connection Not Found, Puppet Run Exiting...")
		
	def callPuppet(self):
		"""Simple utility function that calls puppet via subprocess
		---
		Arguments: None
		Returns: Nothing
		"""
		command = [_PUPPETD]
		task = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
		task.communicate()
	
	def LinkState(self, interface):
		"""This utility returns the status of the passed interface.
		---
		Arguments:
			interface - Either en0 or en1, the BSD interface name of a Network Adapter
		Returns:
			status - The return code of the subprocess call
		"""
		return subprocess.call(["ipconfig", "getifaddr", interface])
		
	def checkIP(self, interface):
		"""This function accepts a BSD interface name and returns the system IP Address
		 	 for that interface using the SystemConfiguration Framework.
		---
		Arguments:
			interface - Either en0 or en1, the BSD interface name of a Network Adapter.
		Returns:
			bool - True or False depending on if the interface is both active and is on the Huron Network.
		"""
		store = SCDynamicStoreCreate(None, "global-network", None , None)
		ifKey = "State:/Network/Interface/" + interface + "/IPv4"
		keyStore = SCDynamicStoreCopyValue(store, ifKey)
		
		try:
			print "The IP Address for interface: " + interface + " is: " + keyStore['Addresses'][0]
		except TypeError:
			syslog.syslog(syslog.LOG_ALERT, "Interface " + interface + " not active.")
			return "false"
			
		return self.checkNetwork(str(keyStore['Addresses'][0]))
	
	def checkNetwork(self, ipAddress):
		"""This function will check to see if the passed IP Address is on the Huron Network
		---
		Arguments:
			ipAddress - A dotted IPv4 Address with four octets
		Returns:
			bool - Either True or False depending on if the IP Address is on the network
		"""
		
		ipAddress = ipAddress.encode('iso-8859-5')
		octet = ipAddress.split('.')
		
		# If the IP address matches the Huron scheme, set onNetwork to true
		if octet[0] == '10':
			if octet[1] == '13':
				syslog.syslog(syslog.LOG_ALERT, "On Huron Network")
				return 'true'
			else:
				syslog.syslog(syslog.LOG_ALERT, "2nd octet doesn\'t match.")
				return 'false'
		else:
			syslog.syslog(syslog.LOG_ALERT, "1st octet doesn\'t match.")
			return 'false'
	
	def checkOD(self):
		"""Checks for an active network connection and then compares the IP address
			to see if it matches the scheme we use in Huron.  If the IP matches, we ensure
			that the search path and contacts path are correct.  If the IP DOESN'T match,
			we remove the search path and contacts path to stabilize logins.
		---
		Arguments:  None
		Returns:
			bool - True or False if an interface is active and has an IP Address on the Huron Network
		"""
		
		# Capture all bound LDAPv3 Servers
		nodes = pymacds.ConfiguredNodesLDAPv3()
		
		if not nodes:
			syslog.syslog(syslog.LOG_ALERT, "We're not bound, skipping all checks.")
			return 'false'
		
			
		# Check all IP Addresses of Network Interfaces to see if we're on the Huron Network
		airportIP = self.checkIP('en1')
		ethernetIP = self.checkIP('en0')
		
		# If either connection is active and on the Huron Network, make sure the Search/Contacts paths
        #  are set properly.
		if airportIP == 'true' or ethernetIP == 'true':
			syslog.syslog(syslog.LOG_ALERT, "Ensuring Bindings.")
			for node in nodes:
				pymacds.EnsureSearchNodePresent(node)
				pymacds.EnsureContactsNodePresent(node)
			return 'true'
			
		# If we're bound and off the Huron Network, remove the Search/Contacts paths
		if airportIP == 'false' and ethernetIP == 'false':
			syslog.syslog(syslog.LOG_ALERT, "Removing Bindings.")
			for node in nodes:
				pymacds.EnsureSearchNodeAbsent(node)
				pymacds.EnsureContactsNodeAbsent(node)
			return 'false'
		else:
			syslog.syslog(syslog.LOG_ALERT, "Weird case where neither if statement in checkOD was true...")
			return 'false'	

	def OnNetworkLoad(self, *args, **kwargs):
		"""Called from crankd directly on a Network State Change. We sleep for 5 seconds to ensure that
			an IP address has been cleared or attained, and then check for OD Bindings and a Puppet run.
		---
		Arguments:
			*args and **kwargs - Catchall arguments coming from crankd
		Returns:  Nothing
		"""
		onNetwork = 'false'
		
		sleep(10)
		onNetwork = self.checkOD()
		
		if onNetwork == 'true':
			self.puppetRun()