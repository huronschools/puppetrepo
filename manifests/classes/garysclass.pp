#/etc/puppet/manifests/classes/garysclass.pp

class garysclass {

	#  Includes
	include general_image
	include hslabs

	# Package Names
	$adobecs3 = "AdobeCS3.dmg"
	$finalcut = "FinalCut.dmg"
	

	# Set Package resource defaults for OS X clients
	Package{ensure => installed,provider => pkgdmg}	

	# Install Specialized Packages
	package{"$finalcut": source => "$pkg_base/$finalcut",}
	package{"$adobecs3": source => "$pkg_base/$adobecs3",}
	
} # End of Class
