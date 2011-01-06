#!/usr/bin/python2.5
#
# Class:
#				CrankTools.py
#		
# Description:
#				This class file is used with crankd to respond to network state changes. The
#				airportStateChange and ethernetStateChange methods are called directly from
#				your crankd plist. All other methods are called from these two. Each method should
#				be documented and inline comments will explain further.
#
# Author:
#				Gary Larizza
#
# Created:
#				10/12/2010
#
# Last Revised:
#				1/6/2011

__author__ = 'Gary Larizza (gary@huronhs.com)'
__version__ = '0.2'

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
_AIRPORT = '/usr/sbin/networksetup'

class CrankTools():
	
	def airportStateChange(self, *args, **kwargs):
		"""Triggered when a "State:/Network/Interface/en1/IPv4" change occurs.  This method will disable
			the Airport if the Ethernet port is also active and on-network.  If the Airport is disabled,
			it will simply log this occurrence. If the Airport is enabled and the Ethernet port is active
			and OFF-NETWORK, it will log this and allow it. If the Airport is enabled and on-network, it
			will ensure the Search and Contact nodes.  If the airport is enabled and off-network, it will
			remove these nodes.
			
			The purpose is to prohibit an Airport and Ethernet simultaneous connection while we're on the
			Huron Network.  When we're off-network, however, we don't care.
		"""
		# Sleep for 10 seconds to allow IP Addresses to be registered.
		# NOTE: If you're having IP Errors, you may need to increase this value. 
		sleep(10)
		
		# Grab IP Addresses and Statuses for both interfaces.
		# NOTE: Hard coding en0 and en1 will cause issues on machines that have multiple network interfaces
		#		  You WILL have to fix this on those machines.
		(en1Status, en1IP) = self.checkIP('en1')
		(en0Status, en0IP) = self.checkIP('en0')
		nodes = pymacds.ConfiguredNodesLDAPv3()
		
		if en1Status == "false":
			if en0Status == "true":
				syslog.syslog(syslog.LOG_ALERT, "The Airport is going down, but the Ethernet interface is active.")
			else:
				syslog.syslog(syslog.LOG_ALERT, "The Airport is going down, and the Ethernet interfaces is inactive.")
				syslog.syslog(syslog.LOG_ALERT, "Removing Bindings")
				for node in nodes:
					pymacds.EnsureSearchNodeAbsent(node)
					pymacds.EnsureContactsNodeAbsent(node)
		else:
			if en0Status == "true":
				if self.checkNetwork(en0IP) == "true":
					syslog.syslog(syslog.LOG_ALERT, "The Ethernet interface is already enabled and on-network. Disabling the Airport Interface.")
					self.toggleAirport('en1', 'off')
					self.callPuppet()
				else:
					syslog.syslog(syslog.LOG_ALERT, "The Ethernet interface is already enabled and off-network. Doing Nothing.")
			else:
				if self.checkNetwork(en1IP) == "true":
					syslog.syslog(syslog.LOG_ALERT, "The Airport interface is on the Huron Network; Ensuring Bindings.")
					for node in nodes:
						pymacds.EnsureSearchNodePresent(node)
						pymacds.EnsureContactsNodePresent(node)
					syslog.syslog(syslog.LOG_ALERT, "Performing a Puppet Run.")
					self.callPuppet()
				else:
					syslog.syslog(syslog.LOG_ALERT, "The Airport interface is off-network; Removing Bindings.")
					for node in nodes:
						pymacds.EnsureSearchNodeAbsent(node)
						pymacds.EnsureContactsNodeAbsent(node)
					
	def ethernetStateChange(self, *args, **kwargs):
		"""Triggered when a "State:/Network/Interface/en0/IPv4" change occurs.  This method will disable
			the Airport if the Ethernet port becomes active and on-network.  If the Ethernet connection is
			disabled, it will simply log this occurrence. If the Ethernet connection is enabled and on-
			network, it will enable the Search and Contact nodes. Finally, if the Ethernet connection is
			enabled and off-network, it will remove these nodes.
		"""
		
		# Sleep for 10 seconds to allow IP Addresses to be registered.
		# NOTE: If you're having IP Errors, you may need to increase this value. 
		sleep(10)
		
		# Grab IP Addresses and Statuses for both interfaces.
		# NOTE: Hard coding en0 and en1 will cause issues on machines that have multiple network interfaces
		#		  You WILL have to fix this on those machines.
		(en1Status, en1IP) = self.checkIP('en1')
		(en0Status, en0IP) = self.checkIP('en0')
		nodes = pymacds.ConfiguredNodesLDAPv3()
		
		if en0Status == "false":
			if en1Status == "true":
				syslog.syslog(syslog.LOG_ALERT, "The Ethernet interface is going down, but the Airport is active.")
			else:
				syslog.syslog(syslog.LOG_ALERT, "The Ethernet interface is going down, and the Airport is inactive.")
				syslog.syslog(syslog.LOG_ALERT, "Removing Bindings")
				for node in nodes:
					pymacds.EnsureSearchNodeAbsent(node)
					pymacds.EnsureContactsNodeAbsent(node)
		else:
			if en1Status == "true":
				if self.checkNetwork(en1IP) == "true":
					if self.checkNetwork(en0IP) == "true":
						syslog.syslog(syslog.LOG_ALERT, "Because both the Airport and Ethernet are enabled and on-network, we're disabling the Airport Interface.")
						self.toggleAirport('en1','off')
						for node in nodes:
							pymacds.EnsureSearchNodePresent(node)
							pymacds.EnsureContactsNodePresent(node)
						syslog.syslog(syslog.LOG_ALERT, "Performing a Puppet Run.")
						self.callPuppet()
					else:
						syslog.syslog(syslog.LOG_ALERT, "The Airport and Ethernet are enabled, but the Airport is on-network and the Ethernet connection is not.")
				else:
					if self.checkNetwork(en0IP) == "true":
						syslog.syslog(syslog.LOG_ALERT, "The Ethernet connection is enabled and on-network, but the Airport connection is also enabled and off-network.")
						syslog.syslog(syslog.LOG_ALERT, "Ensuring Bindings for Ethernet connection.")
						for node in nodes:
							pymacds.EnsureSearchNodePresent(node)
							pymacds.EnsureContactsNodePresent(node)
						syslog.syslog(syslog.LOG_ALERT, "Performing a Puppet Run.")
						self.callPuppet()
					else:
						syslog.syslog(syslog.LOG_ALERT, "Both the Airport and Ethernet connection are enabled and off-network.")
			else:
				if self.checkNetwork(en0IP) == "true":
					syslog.syslog(syslog.LOG_ALERT, "The Ethernet connection is enabled and on-network.")
					syslog.syslog(syslog.LOG_ALERT, "Ensuring Bindings for Ethernet connection.")
					for node in nodes:
						pymacds.EnsureSearchNodePresent(node)
						pymacds.EnsureContactsNodePresent(node)
					syslog.syslog(syslog.LOG_ALERT, "Performing a Puppet Run.")
					self.callPuppet()
				else:
					syslog.syslog(syslog.LOG_ALERT, "The Ethernet connection is enabled and off-network.")
					for node in nodes:
						pymacds.EnsureSearchNodeAbsent(node)
						pymacds.EnsureContactsNodeAbsent(node)

	def callPuppet(self):
		"""Simple utility function that calls puppet via subprocess. The _PUPPETD variable is set globally
			and corresponds to the unified puppet binary (as of 2.6.0).
		---
		Arguments: None
		Returns: Nothing
		"""
		command = [_PUPPETD]
		task = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
		task.communicate()
		
	def checkIP(self, interface):
		"""This function accepts a BSD interface name and returns the state of that interface as
			well as the system IP Address for that interface using the SystemConfiguration Framework.
		---
		Arguments:
			interface - Either en0 or en1, the BSD interface name of a Network Adapter.
		Returns:
			bool - True or False depending on if the interface is both active and is on the Huron Network.
			IP - The IP Address of the interface or 0.0.0.0 if the interface is disabled.
		"""
		store = SCDynamicStoreCreate(None, "global-network", None , None)
		ifKey = "State:/Network/Interface/" + interface + "/IPv4"
		keyStore = SCDynamicStoreCopyValue(store, ifKey)

		try:
			print "The IP Address for interface: " + interface + " is: " + keyStore['Addresses'][0]
		except TypeError:
			syslog.syslog(syslog.LOG_ALERT, "Interface " + interface + " not active.")
			return ("false", "0.0.0.0")

		return ("true", str(keyStore['Addresses'][0]))
		
	def checkNetwork(self, ipAddress):
		"""This function will check to see if the passed IP Address is on the Huron Network.
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
			
	def toggleAirport(self, interface, state):
		"""A utility function that toggles the Airport off or on. The _AIRPORT variable is
			set globally to the networksetup binary.
		---
		Arguments: 
			interface - BSD Interface; either "en0" or "en1"
			state - Either "off" or "on"
		Returns: Nothing
		"""
		command = [_AIRPORT, '-setairportpower', interface, state]
		syslog.syslog(syslog.LOG_ALERT, "Toggling " + interface + " " + state + ".")
		task = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
		task.communicate()