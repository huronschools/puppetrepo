# /etc/puppet/manifests/classes/general_image.pp

class general_image {

	# Includes
	include staff
	include puppet_LaunchDaemon
	#include boe_conf
	
	# Package Names
	$facter = "facter.1.5.7.dmg"
	$puppetcurrent = "puppet-0.25.4.dmg"
	$firstclass = "Firstclass.dmg"
	$textwrangler = "TextWrangler_3.0.dmg"
	$ard = "ardalllocal.dmg"
	$firefox = "Firefox3.6.dmg"

	# Set Package resource defaults for OS X clients
	Package{ensure => installed,provider => pkgdmg}

	# Package Calls
	package{"$facter": 
		source => "$pkg_base/$facter",
		require => Package[$puppetcurrent],
		}
	package{"$puppetcurrent":
		source => "$pkg_base/$facter",
		before => Package[$facter],
		}
	package{"$textwrangler": 
		source => "$pkg_base/$textwrangler",
		provider => appdmg,
		}
	package{"$ard": source => "$pkg_base/$ard",}
	package{"$firefox": 
		source => "$pkg_base/$firefox",
		provider => appdmg,
		}

	case $macosx_productversion_major {
		10.5: { 
			include leopard
		       }			
		10.6: { 
			include snowleopard
	               }
		10.4: { 
			include tiger
		       }
	}

} # End of Class
