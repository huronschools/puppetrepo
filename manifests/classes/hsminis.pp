#/etc/puppet/manifests/classes/hsminis.pp

class hsminis {

	include printers_hhs_g5labbw

	# Package Names
	$hhsdropbox = "hhsdropbox.dmg"

	# Install Required Packages First

	package { "$hhsdropbox":
		source => "$pkg_base/$hhsdropbox",
		provider => appdmg
	}

} # End of Class
