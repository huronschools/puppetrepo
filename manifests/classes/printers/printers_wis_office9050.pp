#/etc/puppet/manifests/classes/printers/printers_wis_office9050.pp

class printers_wis_office9050 {

	exec { "wis_office_9050":
		command => "/usr/sbin/lpadmin -p psm_WIS_Office_9050 -L Woodlands\\ Office -D Woodlands\\ Main\\ Office\\ Copier -v lpd://10.13.3.8/WES_Main_Office_9050 -P /Library/Printers/PPDs/Contents/Resources/HP\\ LaserJet\\ 9050.gz -E -o printer-is-shared=false",
		before => File["/etc/cups/ppd/psm_WIS_Office_9050.ppd"],
		unless => "/usr/bin/lpstat -a psm_WIS_Office_9050",
	}

	file { "/etc/cups/ppd/psm_WIS_Office_9050.ppd":
		owner => "root",
		group => "_lp",
		mode => 644,
		source => "puppet:///files/psm_WIS_Office_9050.ppd",
		ensure => present,
		require => Exec["wis_office_9050"],
	}

} # End of Class