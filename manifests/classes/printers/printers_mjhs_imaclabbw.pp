#/etc/puppet/manifests/classes/printers/printers_mjhs_imaclabbw.pp

class printers_mjhs_imaclabbw {

	exec { "mjhs_imaclab_bw":
		command => "/usr/sbin/lpadmin -p psm_MJHS_Lab_BW -L MJHS\ Computer\ Lab -D MJHS\ Lab\ BW\ Printer -v lpd://10.13.2.7/iMac_Lab_BW_Printer -P /Library/Printers/PPDs/Contents/Resources/HP\ LaserJet\ 4200\ Series.gz -E -o printer-is-shared=false",
		unless => "/usr/bin/lpstat -a psm_MJHS_Lab_BW",
		require => File["/Library/Printers/PPDs/Contents/Resources/HP LaserJet 4200 Series.gz"],
	}

	file { "/Library/Printers/PPDs/Contents/Resources/HP LaserJet 4200 Series.gz":
		owner => "root",
		group => "admin",
		mode => 664,
		source => "puppet:///files/HP LaserJet 4200 Series.gz",
		ensure => present,
		before => Exec["mjhs_imaclab_bw"],
	}

} # End of Class