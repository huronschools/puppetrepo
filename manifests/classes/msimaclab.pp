#/etc/puppet/manifests/classes/msimaclab.pp

class msimaclab {

	#  Include the studentdata class which creates our Student Data Folder
	include hslabs

	# Package Names
	$bootpicker = "bootpicker.dmg"
	$photoshopcs3 = "PhotoshopCS3.dmg"

	# Set Package resource defaults for OS X clients
	Package{ensure => installed,provider => pkgdmg}

	# Package Calls
	package{"$bootpicker": source => "$pkg_base/$bootpicker",}
	package{"$photoshopcs3": source => "$pkg_base/$photoshopcs3",}

} # End of Class
