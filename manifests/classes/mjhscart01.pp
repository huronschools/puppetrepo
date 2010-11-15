# /etc/puppet/manifests/classes/mjhscart01.pp
#

class mjhscart01 {

	# Create the Student Data Folder
	include studentdata
	include studentuser
	include general_image
	include desktopbackground
	include crankd

	# Package Names
	$audacityppc = "AudacityPPC.dmg"
	$dvdunlock = "dvdunlock.dmg"
	$smart = "smartboard101210.dmg"

	# Package Calls
	package{"$audacityppc": source => "$pkg_base/$audacityppc",}
	package{"$dvdunlock": source => "$pkg_base/$dvdunlock",}
	package{"$smart": source => "$pkg_base/$smart"}

} # End of Class

