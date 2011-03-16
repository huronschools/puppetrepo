class printers::drivers {
	require printers::params

	case $operatingsystem {
		"centos": { 
			$hp_lj9040_driver 	= "HP_LaserJet_9040.ppd.gz"
			$hp_lj9050_driver 	= "HP_LaserJet_9050.ppd.gz"
			$hp_lj4250_driver 	= "hp-laserjet_4250-pcl3.ppd.gz"
			$hp_lj4100_driver 	= "hp-laserjet_4100_series-pcl3.ppd.gz"
			$hp_lj8050_driver 	= "HP CM8040 CM8060 MFP.gz"
			$hp_ljcp3505_driver	= "hp-color_laserjet_cp3505-pcl3.ppd.gz"
			$hp_lj9040_source 	= "puppet:///printers/drivers/$operatingsystem/$hp_lj9040_driver"
			$hp_lj9050_source 	= "puppet:///printers/drivers/$operatingsystem/$hp_lj9050_driver"
			$hp_lj4250_source 	= "puppet:///printers/drivers/$operatingsystem/$hp_lj4250_driver"
			$hp_lj4100_source 	= "puppet:///printers/drivers/$operatingsystem/$hp_lj4100_driver"
			$hp_lj8050_source 	= "puppet:///printers/drivers/$operatingsystem/$hp_lj8050_driver"
			$hp_ljcp3505_source = "puppet:///printers/drivers/$operatingsystem/$hp_ljcp3505_driver"
			$hp_lj9040_path 	= "${printers::params::ppd_path}/HP/mono_laser/$hp_lj9040_driver"
			$hp_lj9050_path 	= "${printers::params::ppd_path}/HP/mono_laser/$hp_lj9050_driver"
			$hp_lj4250_path 	= "${printers::params::ppd_path}/HP/mono_laser/$hp_lj4250_driver"
			$hp_lj4100_path 	= "${printers::params::ppd_path}/HP/mono_laser/$hp_lj4100_driver"
			$hp_lj8050_path 	= "${printers::params::ppd_path}/HP/mono_laser/$hp_lj8050_driver"
			$hp_ljcp3505_path 	= "${printers::params::ppd_path}/HP/mono_laser/$hp_ljcp3505_driver"
        }			
		"darwin": { 
			$hp_lj9040_driver 	= "HP LaserJet 9040.gz"
			$hp_lj9050_driver 	= "HP LaserJet 9050.gz"
			$hp_lj4250_driver 	= "HP LaserJet 4250.gz"
			$hp_lj4100_driver 	= "HP LaserJet 4100 Series.gz"
			$hp_lj8050_driver 	= "HP CM8040 CM8060 MFP.gz"
			$hp_ljcp3505_driver = "HP Color LaserJet CP3505.gz"
			$hp_lj9040_source 	= "puppet:///printers/drivers/$macosx_productversion_major/$hp_lj9040_driver"
			$hp_lj9050_source 	= "puppet:///printers/drivers/$macosx_productversion_major/$hp_lj9050_driver"
			$hp_lj4250_source 	= "puppet:///printers/drivers/$macosx_productversion_major/$hp_lj4250_driver"
			$hp_lj4100_source 	= "puppet:///printers/drivers/$macosx_productversion_major/$hp_lj4100_driver"
			$hp_lj8050_source 	= "puppet:///printers/drivers/$macosx_productversion_major/$hp_lj8050_driver"
			$hp_ljcp3505_source = "puppet:///printers/drivers/$macosx_productversion_major/$hp_ljcp3505_driver"
			$hp_lj9040_path 	= "${printers::params::ppd_path}/$hp_lj9040_driver"
			$hp_lj9050_path 	= "${printers::params::ppd_path}/$hp_lj9050_driver"
			$hp_lj4250_path 	= "${printers::params::ppd_path}/$hp_lj4250_driver"
			$hp_lj4100_path 	= "${printers::params::ppd_path}/$hp_lj4100_driver"
			$hp_lj8050_path 	= "${printers::params::ppd_path}/$hp_lj8050_driver"
			$hp_ljcp3505_path 	= "${printers::params::ppd_path}/$hp_ljcp3505_driver"
	    }
	}
	

	file { "HP Laserjet 9040 Driver":
		name		=> "$hp_lj9040_path",
		source		=> "$hp_lj9040_source",
		ensure 		=> present,
		mode		=> 664,
		owner		=> "${printers::params::print_owner}",
		group 		=> "${printers::params::print_group}",
	}
	
	file { "HP Laserjet 9050 Driver":
		name		=> "$hp_lj9050_path",
		source		=> "$hp_lj9050_source",
		ensure 		=> present,
		mode		=> 664,
		owner		=> "${printers::params::print_owner}",
		group 		=> "${printers::params::print_group}",
	}
	
	file { "HP Laserjet 4250 Driver":
		name		=> "$hp_lj4250_path",
		source		=> "$hp_lj4250_source",
		ensure 		=> present,
		mode		=> 664,
		owner		=> "${printers::params::print_owner}",
		group 		=> "${printers::params::print_group}",
	}
	
	file { "HP Laserjet 4100 Driver":
		name		=> "$hp_lj4100_path",
		source		=> "$hp_lj4100_source",
		ensure 		=> present,
		mode		=> 664,
		owner		=> "${printers::params::print_owner}",
		group 		=> "${printers::params::print_group}",
	}
	
	file { "HP Color Laserjet CP3505 Driver":
		name		=> "$hp_ljcp3505_path",
		source		=> "$hp_ljcp3505_source",
		ensure 		=> present,
		mode		=> 664,
		owner		=> "${printers::params::print_owner}",
		group 		=> "${printers::params::print_group}",
	}
	
	
}