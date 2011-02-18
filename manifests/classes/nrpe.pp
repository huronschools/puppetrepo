class nrpe {

	include developertools
	include nagiosusers

	# Package Names
	$nrpe = "NRPE_Setup-20100316.dmg"
	$plugins = "Nagios_Plugins-20100316.dmg"
	
	# Package Calls
	package{"$nrpe": 
		source => "$pkg_base/$nrpe",
		require => Package[$plugins],
	}

	package{"$plugins":
		source => "$pkg_base/$plugins",
		require => User["nagios"],
		before => Package[$nrpe],
	}

}
