#!/usr/bin/ruby
# clearCert.rb
# cgi to clean a cert
class Puppetca
	# removes old certificate if it exists
	# parameter is the certname to use
	# need to allow the _www user to use sudo with the puppetca command
	# added using visudo
	# _www    ALL = NOPASSWD: /usr/bin/puppetca, !/usr/bin/puppetca -- clean --all
	def self.clean certname, addr
		command = "/usr/bin/sudo /usr/sbin/puppetca --clean #{certname}"
		# for some reason the "system" command causes Mac apache to crash
		# when used here
		%x{#{command}}
		%x{"logger #{addr} cleaned #{certname}"}
		return true
	end
end
=begin
CGI starts here
=end
# get the value of the passed param in the URL Query_string
require 'cgi'
cgi=CGI.new
certname = cgi["certname"]
# define the characters that are allow to avoid an injection attack
# 0-9, a-z, period, dash, and colon are allowed. All else is not
pattern = /[^a-z0-9.\-:]/
# determine if any other characters are in the certname
reject = (certname =~ pattern) ? 1 : 0
if ((reject == 0) && Puppetca.clean(certname, ENV['REMOTE_ADDR']))
	cgi.out("status" => "OK", "connection" => "close") {"OK #{certname} cleaned\n"}
else
	cgi.out("status" => "BAD_REQUEST", "connection" => "close") {"Not Processed: #{certname}\n"} 
end
