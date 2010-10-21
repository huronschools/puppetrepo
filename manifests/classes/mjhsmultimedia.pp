#/etc/puppet/manifests/classes/mjhsmultimedia.pp

class mjhsmultimedia {

	#  Includes
	include studentdata
	include general_image
	include desktopbackground

	# Package Names
	$finalcut = "FinalCut.dmg"
	$googleearth = "GoogleEarth.dmg"

	# Set Package resource defaults for OS X clients
	Package{ensure => installed,provider => pkgdmg}	

	# Install Specialized Packages
	package{"$finalcut": 
		source => "http://msdocs.huronhs.com/pkgs/$finalcut",}
	package{"$googleearth": source => "$pkg_base/$googleearth",}

} # End of Class
