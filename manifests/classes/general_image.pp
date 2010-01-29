# /etc/puppet/manifests/classes/general_image.pp

class general_image {

	# Includes
	include staff
	include puppet_conf
	
	# Package Names
	$facter = "facter.1.5.7.dmg"
	$puppetcurrent = "puppet0.25.3.dmg"
	$firstclass = "Firstclass.dmg"
	$textwrangler = "TextWrangler_3.0.dmg"
	$ard = "ardalllocal.dmg"

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
