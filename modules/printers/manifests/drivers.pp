class printers::drivers {
	require printers::params

	case $operatingsystem {
		"centos": { 
			$hp_laserjet_9040 = "HP_LaserJet_9040.ppd.gz"
			$hp_laserjet_9050 = "HP_LaserJet_9050.ppd.gz"
			$hp_lj9040_path = "${printers::params::ppd_path}/HP/mono_laser/$hp_laserjet_9040"
			$hp_lj9050_path = "${printers::params::ppd_path}/HP/mono_laser/$hp_laserjet_9050"
        }			
		"darwin": { 
			$hp_laserjet_9040 = "HP LaserJet 9040.gz"
			$hp_laserjet_9050 = "HP LaserJet 9050.gz"
			$hp_lj9040_path = "${printers::params::ppd_path}/$hp_laserjet_9040"
			$hp_lj9050_path = "${printers::params::ppd_path}/$hp_laserjet_9050"
	    }
	}

	file { "HP Laserjet 9040 Driver":
		name		=> "$hp_lj9040_path",
		source		=> "puppet:///printers/drivers/$hp_laserjet_9040",
		ensure 		=> present,
		mode		=> 664,
		owner		=> "${printers::params::print_owner}",
		group 		=> "${printers::params::print_group}",
	}
	
	file { "HP Laserjet 9050 Driver":
		name		=> "$hp_lj9050_path",
		source		=> "puppet:///printers/drivers/$hp_laserjet_9050",
		ensure 		=> present,
		mode		=> 664,
		owner		=> "${printers::params::print_owner}",
		group 		=> "${printers::params::print_group}",
	}
	
	
}