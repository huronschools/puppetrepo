#/etc/puppet/manifests/classes/mjhsmultimedia.pp

class mjhsmultimedia {

	#  Includes
	include studentdata
	include general
	include desktop
	include desktopbackground

	# Package Names
	$finalcut = "FinalCut.dmg"
	$googleearth = "GoogleEarth.dmg"
	$istop = "iStopMotion_Install-20101220.dmg"

	# Set Package resource defaults for OS X clients
	Package{ensure => installed,provider => pkgdmg}	

	# Install Specialized Packages
	package{"$finalcut": 
		source => "http://msdocs.huronhs.com/pkgs/$finalcut",}
	package{"$googleearth": source => "$pkg_base/$googleearth",}
	package{"$istop": source => "$pkg_base/$istop",}

} # End of Class
