#/etc/puppet/manifests/classes/printers/printers_wis_wing2.pp

class printers_wis_wing2 {

	exec { "wis_wing2":
		command => "/usr/sbin/lpadmin -p psm_WIS_wing2 -L Woodlands\\ Wing -D Woodlands\\ Wing\\ Copier\\ 2 -v lpd://10.13.3.8/WES_Wing_Printer_2 -P /Library/Printers/PPDs/Contents/Resources/HP\\ LaserJet\\ 9040.gz -E -o printer-is-shared=false",
		before => File["/etc/cups/ppd/psm_WIS_wing2.ppd"],
		unless => "/usr/bin/lpstat -a psm_WIS_wing2",
	}

	file { "/etc/cups/ppd/psm_WIS_wing2.ppd":
		owner => "root",
		group => "_lp",
		mode => 644,
		source => "puppet:///files/psm_WIS_wing2.ppd",
		ensure => present,
		require => Exec["wis_wing2"],
	}

} # End of Class