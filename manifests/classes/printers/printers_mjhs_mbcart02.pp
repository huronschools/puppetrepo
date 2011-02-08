#/etc/puppet/manifests/classes/printers/printers_mjhs_mbcart02.pp

class printers_mjhs_mbcart02 {

	exec { "mjhs_mbcart_02":
		command => "/usr/sbin/lpadmin -p psm_MJHS_Mbcart02 -L MJHS\\ Macbook\\ Cart\\ 02 -D MJHS\\ Macbook\\ Cart\\ 02 -v lpd://10.13.2.7/MMS_Macbook_Cart_02 -P /Library/Printers/PPDs/Contents/Resources/HP\\ LaserJet\\ 4250.gz -E -o printer-is-shared=false",
		unless => "/usr/bin/lpstat -a psm_MJHS_Mbcart02",
		require => File["/Library/Printers/PPDs/Contents/Resources/HP LaserJet 4250.gz"],
	}

	file { "/Library/Printers/PPDs/Contents/Resources/HP LaserJet 4250.gz":
		owner => "root",
		group => "admin",
		mode => 664,
		source => "puppet:///files/HP LaserJet 4250.gz",
		ensure => present,
		before => Exec["mjhs_mbcart_02"],
		replace => false,
	}

} # End of Class