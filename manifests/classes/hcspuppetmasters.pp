class hcspuppetmasters {

	include passengerclass
	include puppetusers

#	Package Names
	$developertools = "developertools10.5.dmg"

# 	Set Package resource defaults for OS X clients
#	Package{ensure => installed,provider => pkgdmg}

	package{"$developertools": 
		source => "$pkg_base/$developertools",
		ensure => installed,
		provider => pkgdmg,
		before => Class['passenger'],
		}

	file {"/usr/bin/rubyexternalnode.pp":
		source => "puppet:///files/rubyexternalnode.rb",
		mode => 0755,
		owner => "root",
		group => "wheel",
	}
	
	file {"/Library/WebServer/CGI-Executables/pclean.rb":
	source => "puppet:///files/pclean.rb",
	mode => 0755,
	owner => "root",
	group => "staff",
	}

} # End of Class