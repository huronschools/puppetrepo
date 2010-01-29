#/etc/puppet/manifests/classes/hsimaclab.pp

class sciencelab101 {

	#  Include the studentdata class which creates our Student Data Folder
	include studentdata
	include general_image

	# Package Names
	$quizshow = "QuizShow.dmg"
	$vchem = "VirtualChem.dmg"

	# Set Package resource defaults for OS X clients
	Package{ensure => installed,provider => pkgdmg}

	# Package Calls
	package{"$quizshow": source => "$pkg_base/$quizshow",}
	package{"$vchem": source => "$pkg_base/$vchem",}

} # End of Class
