# /etc/puppet/manifests/classes/leopard.pp
#
#  All the Installation Packages for a Snow Leopard Machine
#

class snowleopard {
	# Package Names
	$ilife = "iLife09.dmg"
	$iwork = "iWork09.dmg"
	$serveradmin = "ServerAdminTools10.6.dmg"
	$timezone = "Timezone.dmg"	

	# Set Package resource defaults for OS X clients
	#Package{ensure => installed,provider => pkgdmg}

	# Package Calls
	package{"$serveradmin": source => "$pkg_base/$serveradmin",}
        package{"$ilife": source => "$pkg_base/$ilife",}
        package{"$iwork": source => "$pkg_base/$iwork",}
	package{"$timezone": source => "$pkg_base/$timezone",}
}
