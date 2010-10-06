# /etc/puppet/manifests/classes/general_image.pp

class general_image {

	# Includes
	include staff
	include puppet_LaunchDaemon
	
	# Package Names
	$facter = "facter-1.5.8.dmg"
	$puppetcurrent = "puppet-0.25.5.dmg"
	$textwrangler = "TextWrangler_3.0.dmg"
	$firefox = "Firefox3.6.dmg"
	$firstclass = "Firstclass20100621.dmg"
	$fcupdate = "firstclass10.013.dmg"
	$flash = "Flash10.1.dmg"
	$sophos = "sophos72810.dmg"
	$dnealian = "dnealian.dmg"

	# Set Package resource defaults for OS X clients
	Package{ensure => installed,provider => pkgdmg}
	
	# Ensure Vardir for .25.4 -> .25.5 clients
	file { "/var/lib/": ensure => directory,}

	# Package Calls
	package{"$facter": 
		source => "$pkg_base/$facter",
		}
	package{"$firstclass": source => "$pkg_base/$firstclass",}
	#package{"$flash": source => "$pkg_base/$flash",}
	package{"$sophos": source => "$pkg_base/$sophos",}
	package{"$dnealian": source => "$pkg_base/$dnealian",}
	package{"$fcupdate": 
		source => "$pkg_base/$fcupdate",
		provider => appdmg,
		require => Package["$firstclass"],
		}
	package{"$textwrangler": 
		source => "$pkg_base/$textwrangler",
		provider => appdmg,
		}
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
