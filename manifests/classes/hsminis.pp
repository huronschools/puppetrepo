#/etc/puppet/manifests/classes/hsminis.pp

class hsminis {

	include printers::hhs_g5labbw
	include hslabs

	# Package Names
	$hhsdropbox = "hhsdropbox.dmg"

	# Install Required Packages First

	package { "$hhsdropbox":
		source => "$pkg_base/$hhsdropbox",
		provider => appdmg
	}

} # End of Class
