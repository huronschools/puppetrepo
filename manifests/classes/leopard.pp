# /etc/puppet/manifests/classes/leopard.pp
#
#  All the Installation Packages for a Leopard Machine
#

class leopard {
	# Package Names
	$ilife         = "iLife09.dmg"
	$iwork 	       = "iWork09.dmg"
	$serveradmin   = "ServerAdmin1057.dmg"
	$timezone      = "Timezone.dmg"	
	$office        = "Office2004.dmg"
	$officeupdates = "OfficeUpdates.dmg"
        $macports      = 'MacPorts-2.0.3-10.5-Leopard.dmg'

	# Package Calls
	package{"$serveradmin": source => "$::pkg_base/$serveradmin",}
        package{"$ilife": 	source => "$::pkg_base/$ilife",}
        package{"$iwork": 	source => "$::pkg_base/$iwork",}
	package{"$timezone": 	source => "$::pkg_base/$timezone",}
	package{$macports:      source => "$::pkg_base/${macports}"}
	package{"$office": 
		source 	=> "$::pkg_base/$office",
		before 	=> Package[$officeupdates],
	}
	package{"$officeupdates": 
		source 	=> "$::pkg_base/$officeupdates",
		require => Package[$office],
	}

}
