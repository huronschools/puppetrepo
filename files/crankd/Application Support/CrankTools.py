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
		"""
		if not self.LinkState('en1'):
			self.callPuppet()
		elif not self.LinkState('en0'):
			self.callPuppet()
		else:
			syslog.syslog(syslog.LOG_ALERT, "Internet Connection Not Found, Puppet Run Exiting...")
		
	def callPuppet(self):
		"""Simple utility function that calls puppet via subprocess
		"""
		command = [_PUPPETD]
		task = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
		task.communicate()
	
	def LinkState(self, interface):
		"""This utility returns the status of the passed interface."""
		status = subprocess.call(["ipconfig", "getifaddr", interface])
		
	def checkIP(self, interface):
		"""This function accepts an interface name and returns an IP Address"""
		store = SCDynamicStoreCreate(None, "global-network", None , None)
		ifKey = "State:/Network/Interface/" + interface + "/IPv4"
		keyStore = SCDynamicStoreCopyValue(store, ifKey)
		
		try:
			print keyStore['Addresses'][0]
		except TypeError:
			syslog.syslog(syslog.LOG_ALERT, "Interface " + interface + " not active.")
			return "false"
			
		return self.onNetwork(str(keyStore['Addresses'][0]))
	
	def onNetwork(self, ipAddress):
		ipAddress = ipAddress.encode('iso-8859-5')
		octet = ipAddress.split('.')
		
		# If the IP address matches the Huron scheme, set onNetwork to true
		if octet[0] == '10':
			if octet[1] == '13':
				syslog.syslog(syslog.LOG_ALERT, "On Huron Network")
				return 'true'
			else:
				syslog.syslog(syslog.LOG_ALERT, "2nd octet doesn\'t match, removing bindings")
				return 'false'
		else:
			syslog.syslog(syslog.LOG_ALERT, "1st octet doesn\'t match, removing bindings")
			return 'false'
	
	def checkOD(self):
		"""Checks for an active network connection and then compares the IP address
			to see if it matches the scheme we use in Huron.  If the IP matches, we ensure
			that the search path and contacts path are correct.  If the IP DOESN'T match,
			we remove the search path and contacts path to stabilize logins.
		"""
		onNetwork = 'false'
		
		if self.LinkState('en1') == 1 and self.LinkState('en0') == 1:
			syslog.syslog(syslog.LOG_ALERT, "Internet Connection Not Found, OD Check Exiting...")
			return onNetwork
			
		# Capture all IP Addresses of Network Interfaces
		airportIP = self.checkIP('en1')
		ethernetIP = self.checkIP('en0')
		
		# Capture all bound LDAPv3 Servers
		nodes = pymacds.ConfiguredNodesLDAPv3()
		
		if airportIP == 'true' or ethernetIP == 'true':
			# If we are on the Huron Network and Bound, make sure the Search/Contacts paths are set
			for node in nodes:
				pymacds.EnsureSearchNodePresent(node)
				pymacds.EnsureContactsNodePresent(node)
			return 'true'
			
		# If we're bound and off the Huron Network, remove the Search/Contacts paths
		if airportIP and ethernetIP == 'false':
			for node in nodes:
				pymacds.EnsureSearchNodeAbsent(node)
				pymacds.EnsureContactsNodeAbsent(node)
			return 'false'

	def OnNetworkLoad(self, *args, **kwargs):
		"""Called from crankd directly on a Network State Change. We sleep for 5 seconds to ensure that
			an IP address has been cleared or attained, and then check for OD Bindings and a Puppet run.
		"""
		sleep(10)
		onNetwork = self.checkOD()
		
		if onNetwork == 'true':
			self.puppetRun()
		
	
