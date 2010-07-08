#!/usr/bin/env ruby
#
# puppetd.rb
#
# Usage:  This script will run puppet from the appropriate server and report back verbosely
#          or silently. There's also a -c argument to clean the puppet SSL and vardir, and
#          the script will check for invalid certs and clean them out.
#
require 'facter'
require 'fileutils'
require 'tempfile'

## Set Environment Variables
ENV['TERM_PROGRAM'] = 'Apple_Terminal'
ENV['TERM'] = 'xterm-color'
$stdout.sync=(true) if not $stdout.sync

## Root Check - Only root should be running this script
if ENV['USER'] != "root"
  puts "This script must be run as root."
  exit(1)
end

##  Variable Declarations
suffix = 'huronhs.com'
ip = Facter.value(:ipaddress).split('.')[2]
mac_uid = %x(nvram MAC_UID 2>/dev/null | awk '{print $2}').chomp
server = case ip
  when 0 then 'testing.huronhs.com'
  when 1, 5 then 'helpdesk.huronhs.com'
  when 2 then 'msreplica.huronhs.com'
  when 3 then 'wesreplica.huronhs.com'
  else 'testing.huronhs.com'
end
command = "http://#{server}/cgi-bin/pclean.rb?certname=#{mac_uid}"

##
# The -c argument will clean the SSL directory, the vardir, and the cert off the server. This is to prep
#  for imaging or to correct a certificate error.
##
if ARGV[0] == "-c"
  puts "Cleaning SSL and Vardir, then cleaning cert from server."
  FileUtils.rm_rf '/etc/puppet/ssl'
  FileUtils.rm_rf '/var/puppet'
  system "curl #{command}"
  exit(0)
end

##
# Our cleaning method - it will remove the SSL and vardir, call the cleaning CGI to remove
#   the cert on the server, and then run puppet twice to ensure a good run
# 
# Arguments: The command to clean the server cert (command), and the certname (mac_uid)
##
def clean_certs (command, mac_uid)
    FileUtils.rm_rf '/etc/puppet/ssl'
    FileUtils.rm_rf '/var/puppet'
    system "curl #{command}"

  5.times do
    putc('.')
    sleep(1)
  end

  system "puppetd -o --no-daemonize --verbose --certname=#{mac_uid} --debug --report 2>&1"  
  system "puppetd -o --no-daemonize --verbose --certname=#{mac_uid} --debug --report 2>&1"  
  system "puppetd -o --no-daemonize --verbose --certname=#{mac_uid} --debug --report 2>&1"  
  system "puppetd -o --no-daemonize --verbose --certname=#{mac_uid} --debug --report 2>&1"
  system "puppetd -o --no-daemonize --verbose --certname=#{mac_uid} --debug --report 2>&1"
  exit(0)
end

##
# Test for mac_uid availability. By default the certs are set to the system's Hardware Serial #
##
if mac_uid.empty?
  nvram = "no"
  mac_uid = %x(system_profiler SPHardwareDataType | awk '/Serial Number/ {print $NF}').chomp.downcase + "." + suffix
  if mac_uid.empty?
    mac_uid = %x(hostname).chomp
  end
end

## If variable wasn't in nvram, set it
if nvram == "no"
  %x(/usr/sbin/nvram MAC_UID=#{mac_uid})
end

##
# If the -v argument is set, return everything from the puppet run and log commands into a 
#  temporary file.  Next, check for certain certificate errors in the output and clean the certs if need be.
#
# If the -v argument is NOT set, run puppet silently, log all output to the puppet_results variable,
#  and check for our certificate errors (cleaning certs as warranted)
##
if ARGV[0] == "-v"
  arg_file = Tempfile.new('puppetd')
  puts "puppetd -o --no-daemonize --verbose --certname=#{mac_uid} --debug --report"
  system "puppetd -o --no-daemonize --verbose --certname=#{mac_uid} --debug --report 2>&1 | /usr/bin/tee #{arg_file.path}"
  cert_error = system "cat #{arg_file.path} | grep -q \"/Certificate request does not match existing certificate\" "
  cert_error = system "cat #{arg_file.path} | grep -q \"Retrieved certificate does not match private key\" "
else
   puppet_results = %x(puppetd -o --no-daemonize -v --certname=#{mac_uid} --report 2>&1)
  if /Retrieved certificate does not match private key/ =~ puppet_results || /Certificate request does not match existing certificate/ =~ puppet_results
    cert_error = true
  end
end

##
# If a certificate error was found, then call the clean_certs method
##
if cert_error
  puts "A certificate error has been found - cleaning SSL and Vardir, then cleaning cert from server."
  clean_certs(command, mac_uid)
else
  exit(0)
end