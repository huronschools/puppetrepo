# /etc/puppet/manifests/classes/general_image.pp

class general_image {

	# Includes
	include puppet_LaunchDaemon

	
	# Package Names
	$facter = "facter-1.5.8.dmg"
	$puppetcurrent = "puppet-2.6.2.dmg"
	$textwrangler = "TextWrangler_3.0.dmg"
	$firefox = "firefox3.6.11.dmg"
	$firstclass = "Firstclass20100621.dmg"
	$fcupdate = "firstclass10.013.dmg"
	$flash = "Flash10.1.dmg"
	$sophos = "sophos72810.dmg"
	$dnealian = "dnealian.dmg"
	
	# Ensure Vardir for .25.4 -> .25.5 clients
	file { "/var/lib/": 
		ensure 		=> directory,
	}
	
	# Templating Example
	file { "/etc/puppet/template.txt":
		ensure 	=> file,
		content => template("sample.erb"),
	}
	
	# Ensure our /etc/facts.txt file exists
	file { "/etc/facts.txt":
		ensure => file,
	}

	# Package Calls
	package{"$facter": 
		source 		=> "$pkg_base/$facter",
		before		=> Package["$puppetcurrent"],
	}
	package{"$puppetcurrent":
		source 		=> "$pkg_base/$puppetcurrent",
	}	
	package{"$firstclass": 
		source 		=> "$pkg_base/$firstclass",
	}
	package{"$sophos": 
		source 		=> "$pkg_base/$sophos",
	}
	package{"$dnealian": 
		source 		=> "$pkg_base/$dnealian",
	}
	package{"$fcupdate": 
		source 		=> "$pkg_base/$fcupdate",
		provider 	=> appdmg,
		require 	=> Package["$firstclass"],
	}
	package{"$textwrangler": 
		source 		=> "$pkg_base/$textwrangler",
		provider 	=> appdmg,
	}
	package{"$firefox": 
		source 		=> "$pkg_base/$firefox",
		provider 	=> appdmg,
	}
	
	case $macosx_productversion_major {
		10.5: { 
			include leopard
			include mcollective
		       }			
		10.6: { 
			include snowleopard
			include mcollective
	               }
		10.4: { 
			include tiger
		       }
	}

} # End of Class
