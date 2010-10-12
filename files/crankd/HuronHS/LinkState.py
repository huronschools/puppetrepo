#!/usr/bin/python2.5
#
#  LinkState.py - Library function for determining that state of network adapters
#

__author__ = 'Gary Larizza (gary@huronhs.com)'
__version__ = '0.1'

import subprocess

_IPCONFIG = '/usr/sbin/ipconfig'

def status(NetPort):
	"""Uses /usr/sbin/ipconfig to check link status of a network adapter
	
	Args:
		NetPort: One of 'en0' or 'en1' - Ethernet or Airport
	Returns:
		Exit status code which determines link status. 0 is active, 1 is inactive.
	"""
	
	command = [_IPCONFIG, 'getifaddr', NetPort]
	task = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
	(stdout, stderr) = task.communicate()
	return task.returncode

