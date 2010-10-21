# /etc/puppet/manifests/classes/hssped.pp

class hssped {

	# Includes
	include staff
	include general_image

	# Package Names
	$adobereader = "adobereader9.dmg"

	# Set Pacakge resource defaults for OS X clients
	Package{ensure => installed,provider => pkgdmg}

	# Package Calls
	package{"$adobereader": source => "$pkg_base/$adobereader",}

} # End of class
