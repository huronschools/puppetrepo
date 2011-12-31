# /etc/puppet/manifests/classes/leopard.pp
#
#  All the Installation Packages for a Snow Leopard Machine
#

class snowleopard {

	include office2008

	# Package Names
	$ilife       = "iLife09.dmg"
	$iwork       = "iWork09.dmg"
	$serveradmin = "ServerAdminTools10.6.dmg"
	$timezone    = "Timezone.dmg"	
	$rosetta     = "Rosetta.dmg"
	$flash       = "Flash_Installer_64_Bit-20100920.dmg"
	$shockwave   = "Shockwave64bit.dmg"
	$gbloops     = "GaragebandLoops.dmg"
	$macports    = 'MacPorts-2.0.3-10.6-SnowLeopard.dmg'

	# Set Package resource defaults for OS X clients
	Package{ensure => installed,provider => pkgdmg}

	# Package Calls
	package{"$serveradmin": source => "$::pkg_base/$serveradmin",}
    	package{$macports: source => "${::pkg_base}/${macports}"}
	package{"$ilife": source => "$::pkg_base/$ilife",}
	package{"$gbloops":
			source 	=> "$::pkg_base/$gbloops",
			require	=> Package["$ilife"],
		}
    	package{"$iwork": source => "$::pkg_base/$iwork",}
	package{"$timezone": source => "$::pkg_base/$timezone",}
	package{"$rosetta": source =>"$::pkg_base/$rosetta",}
	package{"$flash": source =>"$::pkg_base/$flash",}
	package{"$shockwave": source =>"$::pkg_base/$shockwave",}
}
