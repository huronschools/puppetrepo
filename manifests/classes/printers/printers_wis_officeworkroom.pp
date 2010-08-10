#/etc/puppet/manifests/classes/printers/printers_wis_officeworkroom.pp

class printers_wis_officeworkroom {

	exec { "wis_office_workroom":
		command => "/usr/sbin/lpadmin -p psm_WIS_Office_Workroom -L Woodlands\\ Workroom -D Woodlands\\ Office\\ Workroom\\ Copier -v lpd://10.13.3.8/WES_Library_9040 -P /Library/Printers/PPDs/Contents/Resources/HP\\ LaserJet\\ 9040.gz -E -o printer-is-shared=false",
		before => File["/etc/cups/ppd/psm_WIS_Office_Workroom.ppd"],
		unless => "/usr/bin/lpstat -a psm_WIS_Office_Workroom",
	}

	file { "/etc/cups/ppd/psm_WIS_Office_Workroom.ppd":
		owner => "root",
		group => "_lp",
		mode => 644,
		source => "puppet:///files/psm_WIS_Office_Workroom.ppd",
		ensure => present,
		require => Exec["wis_office_workroom"],
	}

} # End of Class