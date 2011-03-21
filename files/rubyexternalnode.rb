#!/usr/bin/env ruby
#
#
#  This External Node classifier script will return appropriate classes for Puppet depending
#   on the machine's huron_class fact.  The script will dip into the Server's YAML depository,
#   search for the passed certname, extract the fact information, and return a YAML block to
#   puppet.
#
#  Created by Gary Larizza - 6.10.2010
#  Last Modified - 3.21.2011
#
#

require 'yaml'
require 'puppet'

# Intitialize Variables
vardir = "/var/lib/puppet"
yamldir = "#{vardir}/yaml/facts/"
default = {'classes' => []}
yaml_output = {}

# Check to see if the Node YAML file exists.
# If it exists, set the huron_class variable to that fact's value
begin
  yamlfile = YAML::load_file(yamldir + ARGV[0] + '.yaml').values
  huron_class = yamlfile["huron_class"]
  environment = yamlfile["environment"]
rescue Exception => error
  puts "Node YAML file was not found!  Error: " + error
  exit(1)
end

# If huron_class is nil or "nodes.pp", escape with a blank YAML output
if huron_class.nil? or huron_class == "nodes.pp"
  print default.to_yaml
  exit(0)
end

# Output our classes and environment values to YAML for Puppet
yaml_output =  {'classes' => huron_class.split(','), 'environment' => environment}
print yaml_output.to_yaml
