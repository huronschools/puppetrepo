#/etc/puppet/manifests/classes/hslabs.pp

class hslabs {

	# Includes
	include general_image
	include studentdata

	# Package Names
	$studio8 = "Studio8.dmg"
	$audacityppc = "AudacityPPC.dmg"
	$fmpro = "FilemakerPro.dmg"
	$imagein = "ImageIn.dmg"
	$keychainminder = "KeychainMinder.dmg"
	$hpscanjet = "HPScanjet.dmg"

	# Set Package resource defaults for OS X clients
	Package{ensure => installed,provider => pkgdmg}

	#Package Calls
	package{"$studio8": source => "$pkg_base/$studio8",}
	package{"$alice": source => "$pkg_base/$alice",}
	package{"$audacityppc": source => "$pkg_base/$audacityppc",}
	package{"$fmpro": source => "$pkg_base/$fmpro",}
	package{"$keychainminder": source => "$pkg_base/$keychainminder",}
	package{"$hpscanjet": source => "$pkg_base/$hpscanjet",}


} # End of Class
