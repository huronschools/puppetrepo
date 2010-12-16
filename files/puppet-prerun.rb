#!/usr/bin/env ruby
#
# puppet-prerun.rb
#
# Usage:  This script runs before puppet is called. It checks for /etc/facts.txt,
#          puppet.conf, and checks for (and age of) $vardir/state/puppetdlock.
#          If this script exits other than 0, puppet doesn't run.
#
require 'facter'
require 'puppet'
require 'fileutils'

## Set Environment and Global Variables
ENV['TERM_PROGRAM'] = 'Apple_Terminal'
ENV['TERM'] = 'xterm-color'
ENV['PATH'] = '/usr/sbin:/usr/bin:/bin'
$stdout.sync=(true) if not $stdout.sync
$ip = Facter.value(:ipaddress).split('.')[2]
$vardir = Puppet[:vardir]

#  Set our Puppet server variable according to the building we're in.  We determine
#  this by checking the third octet in our IP Address.
$server = case $ip
  when '0' then 'testing.huronhs.com'
  when '1', '5' then 'helpdesk.huronhs.com'
  when '2' then 'msreplica.huronhs.com'
  when '3' then 'wesreplica.huronhs.com'
  else 'testing.huronhs.com'
end
  
def setPuppetConf()
  confHash = {} # Our hash of puppet.conf keys and values
  
  # Get the certname by checking for a variable in nvram (which puppetd.rb uses).
  # If this variable doesn't exist, set mac_uid to the Serial Number.huronhs.com.
  # Failing that, use the hostname.
  mac_uid = %x(nvram MAC_UID 2>/dev/null | awk '{print $2}').chomp

  if mac_uid.empty?
    mac_uid = %x(system_profiler SPHardwareDataType | awk '/Serial Number/ {print $NF}').chomp.downcase.concat(".huronhs.com")
    if mac_uid == ".huronhs.com"
      mac_uid = %x(hostname).chomp
    end
  end
  
  # Set the confHash equal to all your puppet.conf settings
  confHash = {"server" => $server, "certname" => mac_uid, "pluginsync" => "true", "factpath" => "$vardir/lib/facter"}
  
  # Output values to the puppet.conf file
  File.open("/etc/puppet/puppet.conf", 'w') {|f| 
    f.write("[main]\n")
    confHash.each{|key,value| f.write(key + " = " + value + "\n")}
  }
end

def setEtcFacts
  etcHash = {}

  # The huron_class fact is a list of classes that should be applied to our machines.
  # Set the initial value equal to the building/function sections of each machine's hostname.
  # If the hostname does not conform, set huron_class equal to our general_image class.
  huron_class = %x{hostname | awk -F '-' '{print $2 "," $3}'}.chomp.gsub!(/[.].*/,"")
  
  # If our hostname does not match the district format, set huron_class to nodes.pp - this
  # way our External Node Classifier script will recognize this and default to the nodes.pp
  # file class declarations.
  if huron_class == "," or huron_class == nil
    huron_class = "nodes.pp"
   end
  
  # Output values to /etc/facts.txt file
  etcHash = {"huron_class" => huron_class, "environment" => "production"}
  File.open("/etc/facts.txt", 'w') {|g| etcHash.each{|key, value| g.write(key + "=" + value + "\n")}}  
end

# If there's no puppet.conf file, set a default one.
if !File.exists?("/etc/puppet/puppet.conf")
  setPuppetConf()
end

# If there's not an /etc/facts.txt file, set a default one.
if !File.exists?("/etc/facts.txt")
  setEtcFacts()
end

# If the Puppetd lock exists, check to see if it's older than a day.  If so, delete it.
# We don't use the puppetdlock to disable puppet - we're using a Big Red Button ©
if File.exists?("#{$vardir}/state/puppetdlock")
  difference = Time.now - File.mtime("#{$vardir}/state/puppetdlock")
  days = difference.divmod(60)[0].divmod(60)[0].divmod(24)[0]
  FileUtils.rm("#{$vardir}/state/puppetdlock") if days > 1
end

# Exit with a status of 0 to continue our puppet run.
exit(0)