# /etc/puppet/modules/printers/manifests/params.pp

class printers::params {
	
	$darwinprintgroup = $macosx_productversion_major ? {
		"10.4"		=> "lp",
		"10.5"		=> "_lp",
		"10.6"		=> "_lp",
		default		=> "lp",
	}
	
	case $operatingsystem {
		"centos": { 
			$ppd_path = "/usr/share/cups/model/foomatic-db-ppds"
			$print_group = "root"
			$print_owner = "root"
			$hp_laserjet_9040 = "HP_LaserJet_9040.ppd.gz"
			$hp_laserjet_9050 = "HP_LaserJet_9050.ppd.gz"	
        }			
		"darwin": { 
			$ppd_path = "/Library/Printers/PPDs/Contents/Resources"
			$print_group = "$darwinprintgroup"
			$print_owner = "root"
			$hp_laserjet_9040 = "HP LaserJet 9040.gz"
			$hp_laserjet_9050 = "HP LaserJet 9050.gz"
	    }
	}
}