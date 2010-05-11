#/etc/puppet/manifests/classes/hsimaclab.pp

class sciencelab105 {

	#  Include the studentdata class which creates our Student Data Folder
	include sciencelab101

	#Package Names
	$alice = "Alice.dmg"

	# Set Package Resource
	Package{ensure => installed,provider => pkgdmg}

	# Package Calls
	package{"$alice": source => "$pkg_base/$alice",}

} # End of Class
