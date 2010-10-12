#!/usr/bin/python2.5
#
# Copyright 2009 Google Inc.
# All Rights Reserved.
#

"""googlecorp.ds - various directoryservice related functions."""

__author__ = 'Nigel Kersten (nigelk@google.com)'
__version__ = '0.1'


import subprocess
import os
from Foundation import NSString
import plistlib


_DSCL = '/usr/bin/dscl'
_DSCACHEUTIL = '/usr/bin/dscacheutil'


class DSException(Exception):
  """Module specific error class."""
  pass

def GetLDAPServer():
	node = os.popen('dscl localhost -list /LDAPv3')
	node = str(node.read())
	node = '/LDAPv3/' + node[:-1]
	return node

def FlushCache():
  """Flushes the DirectoryService cache."""
  command = [_DSCACHEUTIL, '-flushcache']
  subprocess.call(command)


def _GetCSPSearchPathForPath(path):
  """Returns list of search nodes for a given path.

  Args:
	path: One of '/Search' or '/Search/Contacts' only.
  Returns:
	nodes: list of search nodes for given path.
  Raises:
	DSException: Unable to retrieve search nodes in path.
  """

  command = [_DSCL, '-plist', path, '-read', '/', 'CSPSearchPath']
  task = subprocess.Popen(command, stdout=subprocess.PIPE,
						  stderr=subprocess.PIPE)
  (stdout, stderr) = task.communicate()
  result = plistlib.readPlistFromString(stdout)
  if 'dsAttrTypeStandard:CSPSearchPath' in result:
	search_nodes = result['dsAttrTypeStandard:CSPSearchPath']
	return search_nodes
  else:
	raise DSException('Unable to retrieve search nodes: %s' % stderr)


def _ModifyCSPSearchPathForPath(action, node, path):
  """Modifies the search nodes for a given path.

  Args:
	action: one of (["append", "delete"]) only.
	node: the node to append or delete.
	path: the DS path to modify.
  Returns:
	True on success
  Raises:
	DSException: Could not modify nodes for path.
  """

  command = [_DSCL, path, '-%s' % action, '/', 'CSPSearchPath', node]
  task = subprocess.Popen(command, stdout=subprocess.PIPE,
						  stderr=subprocess.PIPE)
  (unused_stdout, stderr) = task.communicate()

  if task.returncode:
	raise DSException('Unable to perform %s on CSPSearchPath '
					  'for node: %s on path: %s '
					  'Error: %s '% (action, node, path, stderr))
  FlushCache()
  return True


def GetSearchNodes():
  """Returns search nodes for DS /Search path."""
  return _GetCSPSearchPathForPath('/Search')


def GetContactsNodes():
  """Returns search nodes for DS /Search/Contacts path."""
  return _GetCSPSearchPathForPath('/Search/Contacts')


def AddNodeToSearchPath(node):
  """Adds a given DS node to the /Search path."""
  _ModifyCSPSearchPathForPath('append', node, '/Search')


def AddNodeToContactsPath(node):
  """Adds a given DS node to the /Search/Contacts path."""
  _ModifyCSPSearchPathForPath('append', node, '/Search/Contacts')


def DeleteNodeFromSearchPath(node):
  """Deletes a given DS node from the /Search path."""
  _ModifyCSPSearchPathForPath('delete', node, '/Search')


def DeleteNodeFromContactsPath(node):
  """Deletes a given DS node from the /Search/Contacts path."""
  _ModifyCSPSearchPathForPath('delete', node, '/Search/Contacts')


def EnsureSearchNodePresent(node):
  """Ensures a given DS node is present in the /Search path."""
  if node not in GetSearchNodes():
	AddNodeToSearchPath(node)


def EnsureSearchNodeAbsent(node):
  """Ensures a given DS node is absent from the /Search path."""
  if node in GetSearchNodes():
	DeleteNodeFromSearchPath(node)


def EnsureContactsNodePresent(node):
  """Ensures a given DS node is present in the /Search/Contacts path."""
  if node not in GetContactsNodes():
	AddNodeToContactsPath(node)


def EnsureContactsNodeAbsent(node):
  """Ensures a given DS node is absent from the /Search path."""
  if node in GetContactsNodes():
	DeleteNodeFromContactsPath(node)


def DSQuery(dstype, objectname, attribute):
  """DirectoryServices query.

  Args:
	dstype: The type of objects to query. user, group.
	objectname: the object to query.
	attribute: the attribute to query.
  Returns:
	the value of the attribute. If single-valued array, return single value.
  Raises:
	DSException: Cannot query DirectoryServices.
  """
  ds_path = '/%ss/%s' % (dstype.capitalize(), objectname)
  cmd = [_DSCL, '-plist', '.', '-read', ds_path, attribute]
  task = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
  (stdout, stderr) = task.communicate()
  if task.returncode:
	raise DSException('Cannot query %s for %s: %s' % (ds_path,
													  attribute,
													  stderr))
  plist = NSString.stringWithString_(stdout).propertyList()
  if 'dsAttrTypeStandard:%s' % attribute in plist:
	value = plist['dsAttrTypeStandard:%s' % attribute]
	if len(value) == 1:
	  return value[0]
	else:
	  return value
  else:
	return None


def UserAttribute(username, attribute):
  """Returns the requested DirectoryService attribute for this user.

  Args:
	username: the user to retrieve a value for.
	attribute: the attribute to retrieve.
  Returns:
	the value of the attribute.
  """
  return DSQuery('user', username, attribute)


def GroupAttribute(groupname, attribute):
  """Returns the requested DirectoryService attribute for this group.

  Args:
	groupname: the group to retrieve a value for.
	attribute: the attribute to retrieve.
  Returns:
	the value of the attribute.
  """
  return DSQuery('group', groupname, attribute)
