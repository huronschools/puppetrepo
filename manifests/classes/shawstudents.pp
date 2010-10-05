#/etc/puppet/manifests/classes/shawstudents.pp

class shawstudents {

	#  Includes
	include studentdata
	include wiscart01

	# Package Names
	$timetogo = "TimeToGo.dmg"
	
	# Install Required Packages First
	package{"$timetogo": 
		source =>"$pkg_base/$timetogo",
		provider => appdmg,
		}
		
} # End of Class
