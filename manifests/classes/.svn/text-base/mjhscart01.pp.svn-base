# /etc/puppet/manifests/classes/mjhscart01.pp
#

class mjhscart01 {

	# Create the Student Data Folder
	include studentdata
	include general_image

	# Package Names
	$audacityppc = "AudacityPPC.dmg"
	$dvdunlock = "dvdunlock.dmg"

	# Set Package Defaultss
	Package{ensure => installed,provider =>pkgdmg}

	# Package Calls
	package{"$audacityppc": source => "$pkg_base/$audacityppc",}
	package{"$dvdunlock": source => "$pkg_base/$dvdunlock",}

} # End of Class

