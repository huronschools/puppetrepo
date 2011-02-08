#/etc/puppet/manifests/classes/printers/printers_mjhs_mbcart01.pp

class printers_mjhs_mbcart01 {

	exec { "mjhs_mbcart_01":
		command => "/usr/sbin/lpadmin -p psm_MJHS_Mbcart01 -L MJHS\\ Macbook\\ Cart\\ 01 -D MJHS\\ Macbook\\ Cart\\ 01 -v lpd://10.13.2.7/MMS_Macbook_Cart -P /Library/Printers/PPDs/Contents/Resources/HP\\ LaserJet\\ 4100\\ Series.gz -E -o printer-is-shared=false",
		unless => "/usr/bin/lpstat -a psm_MJHS_Mbcart01",
		require => File["/Library/Printers/PPDs/Contents/Resources/HP LaserJet 4100 Series.gz"],
	}

	file { "/Library/Printers/PPDs/Contents/Resources/HP LaserJet 4100 Series.gz":
		owner => "root",
		group => "admin",
		mode => 664,
		source => "puppet:///files/HP LaserJet 4100 Series.gz",
		ensure => present,
		before => Exec["mjhs_mbcart_01"],
		replace => false,
	}

} # End of Class