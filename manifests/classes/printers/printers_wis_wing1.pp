#/etc/puppet/manifests/classes/printers/printers_wis_wing1.pp

class printers_wis_wing1 {

	exec { "wis_wing1":
		command => "/usr/sbin/lpadmin -p psm_WIS_Wing1 -L Woodlands\\ Wing -D Woodlands\\ Wing\\ Copier\\ 1 -v lpd://10.13.3.8/WES_Wing_Printer_1 -P /Library/Printers/PPDs/Contents/Resources/HP\\ LaserJet\\ 9040.gz -E -o printer-is-shared=false",
		before => File["/etc/cups/ppd/psm_WIS_Wing1.ppd"],
		unless => "/usr/bin/lpstat -a psm_WIS_Wing1",
	}

	file { "/etc/cups/ppd/psm_WIS_Wing1.ppd":
		owner => "root",
		group => "_lp",
		mode => 644,
		source => "puppet:///files/psm_WIS_Wing1.ppd",
		ensure => present,
		require => Exec["wis_wing1"],
	}

} # End of Class