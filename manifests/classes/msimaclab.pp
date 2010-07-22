#/etc/puppet/manifests/classes/msimaclab.pp

class msimaclab {

	#  Include the studentdata class which creates our Student Data Folder
	include hslabs
	include desktopbackground
	include printers_mjhs_office9050
	include printers_mjhs_office9040

	# Package Names
	$photoshopcs3 = "PhotoshopCS3.dmg"

	# Set Package resource defaults for OS X clients
	Package{ensure => installed,provider => pkgdmg}

	# Package Calls
	package{"$photoshopcs3": source => "$pkg_base/$photoshopcs3",}

} # End of Class
