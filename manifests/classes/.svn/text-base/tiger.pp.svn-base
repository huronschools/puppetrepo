# /etc/puppet/manifests/classes/Tiger.pp
#
#  All the Installation Packages for a Tiger Machine
#

class tiger {
	# Package Names
	$ilife = "iLife08.dmg"
	$safari = "Safari4.0.4Tiger.dmg"
	$office = "Office2004.dmg"
	$officeupdates = "OfficeUpdates.dmg"		

	# Set Package resource defaults for OS X clients
	#Package{ensure => installed,provider => pkgdmg}

	# Package Calls
	package{"$ilife": source => "$pkg_base/$ilife",}
	package{"$safari": source => "$pkg_base/$safari",}
	package{"$office": 
		source => "$pkg_base/$office",
		before => Package[$officeupdates],
		}
	package{"$officeupdates": 
		source => "$pkg_base/$officeupdates",
		require => Package[$office],
		}

}
