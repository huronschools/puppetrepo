# /etc/puppet/manifests/classes/leopard.pp
#
#  All the Installation Packages for a Leopard Machine
#

class leopard {
	# Package Names
	$ilife = "iLife09.dmg"
	$iwork = "iWork09.dmg"
	$serveradmin = "ServerAdmin1057.dmg"
	$timezone = "Timezone.dmg"	
	$office = "Office2004.dmg"
	$officeupdates = "OfficeUpdates.dmg"

	# Set Package resource defaults for OS X clients
	#Package{ensure => installed,provider => pkgdmg}

	# Package Calls
	package{"$serveradmin": source => "$pkg_base/$serveradmin",}
        package{"$ilife": source => "$pkg_base/$ilife",}
        package{"$iwork": source => "$pkg_base/$iwork",}
	package{"$timezone": source => "$pkg_base/$timezone",}
	package{"$office": 
		source => "$pkg_base/$office",
		before => Package[$officeupdates],
		}
	package{"$officeupdates": 
		source => "$pkg_base/$officeupdates",
		require => Package[$office],
		}

}
