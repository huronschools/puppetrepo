#/etc/puppet/manifests/classes/mjhsmultimedia.pp

class mjhsmultimedia {

	#  Includes
	include studentdata
	include general_image

	# Package Names
	$finalcut = "FinalCut.dmg"
	$googleearth = "GoogleEarth.dmg"

	# Set Package resource defaults for OS X clients
	Package{ensure => installed,provider => pkgdmg}	

	# Install Specialized Packages
#	package{"$finalcut": source => "$pkg_base/$finalcut",}
	package{"$googleearth": source => "$pkg_base/$googleearth",}

} # End of Class
