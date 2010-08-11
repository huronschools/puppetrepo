#/etc/puppet/manifests/classes/hsminis.pp

class hsminis {

	# Package Names
	$hsdropbox = "hsdropbox.dmg"

	# Install Required Packages First

	package { "$hsdropbox":
		source => "$pkg_base/$hsdropbox",
		provider => appdmg
	}

} # End of Class
