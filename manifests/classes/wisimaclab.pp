#/etc/puppet/manifests/classes/wisimaclab.pp

class wisimaclab {

	#  Includes
	include studentdata
	include hslabs
	include general_image
	include desktopbackground
	include wiscart01
#	include studentuser

	# Package Names
	$timetogo = "TimeToGo.dmg"
	
	# Install Required Packages First
	package{"$timetogo": 
		source =>"$pkg_base/$timetogo",
		provider => appdmg,
		}
		
} # End of Class
