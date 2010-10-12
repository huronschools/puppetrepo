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
import LinkState
import dsutils
import syslog
import subprocess
import os
import socket
from time import sleep

syslog.openlog("CrankD")
_PUPPETD = '/usr/bin/puppetd.rb'

class CrankTools():
	"""The main CrankTools class needed for our crankd config plist"""
	
	def crankdRun(self):
		"""Checks for an active network connection and calls puppet if it finds one.  
			If the network is NOT active, it logs an error and exits
		"""
		if LinkState.status('en1') == 0:
			self.callPuppet()
		elif LinkState.status('en0') == 0:
			self.callPuppet()
		else:
			syslog.syslog(syslog.LOG_ALERT, "Internet Connection Not Found, Puppet Run Exiting...")
		
	def callPuppet(self):
		"""Simple utility function that calls puppet via subprocess
		"""
		command = [_PUPPETD]
		task = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
		task.communicate()
	
	def checkOD(self):
		"""Checks for an active network connection and then compares the IP address
			to see if it matches the scheme we use in Huron.  If the IP matches, we ensure
			that the search path and contacts path are correct.  If the IP DOESN'T match,
			we remove the search path and contacts path to stabilize logins.
		"""
		
		if LinkState.status('en1') == 1 and LinkState.status('en0') == 1:
			syslog.syslog(syslog.LOG_ALERT, "Internet Connection Not Found, OD Check Exiting...")
			return
			
		# Capture all IP Addresses of Network Interfaces
		ip = socket.gethostbyname_ex(socket.gethostname())[-1]

		# Set 'node' to be the server to which we're bound (IF we're bound)
		node = dsutils.GetLDAPServer()

		# If we are bound to a server....
		if node != "/LDAPv3/":

		# Check to see if we're on the HuronHS Network
		# If we are, ensure the Search Paths are correct
		# If not, strip out Search Paths
			for i in ip:
				octet=i.split('.')
				if octet[0] == '10':
					if octet[1] == '13':
						dsutils.EnsureSearchNodePresent(node)
						dsutils.EnsureContactsNodePresent(node)
						syslog.syslog(syslog.LOG_ALERT, "On Huron Network")
						#logging.info('On Huron Network')
						
						break
					else:
						syslog.syslog(syslog.LOG_ALERT, "2nd octet doesn\'t match, removing bindings")
						dsutils.DeleteNodeFromSearchPath(node)
						dsutils.DeleteNodeFromContactsPath(node)
				else:
					syslog.syslog(syslog.LOG_ALERT, "1st octet doesn\'t match, removing bindings")
					dsutils.DeleteNodeFromSearchPath(node)
					dsutils.DeleteNodeFromSearchPath(node)	
		else:
			syslog.syslog(syslog.LOG_ALERT, "We\'re not bound")

	def OnNetworkLoad(self, *args, **kwargs):
		"""Called from crankd directly on a Network State Change. We sleep for 5 seconds to ensure that
			an IP address has been cleared or attained, and then check for OD Bindings and a Puppet run.
		"""
		sleep(5)
		self.checkOD()
		self.crankdRun()
	
