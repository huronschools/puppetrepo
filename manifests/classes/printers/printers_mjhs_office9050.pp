#/etc/puppet/manifests/classes/printers/printers_mjhs_office9050.pp

class printers_mjhs_office9050 {

	exec { "mjhs_office_9050":
		command => "/usr/sbin/lpadmin -p psm_MJHS_Office_9050 -L MJHS\\ Office -D MJHS\\ Main\\ Office\\ 9050\\ Copier -v lpd://10.13.2.7/Main_Office_9050_Copier -P /Library/Printers/PPDs/Contents/Resources/HP\\ LaserJet\\ 9050.gz -E -o printer-is-shared=false",
		before => File["/etc/cups/ppd/psm_MJHS_Office_9050.ppd"],
		unless => "/usr/bin/lpstat -a psm_MJHS_Office_9050",
	}

	file { "/etc/cups/ppd/psm_MJHS_Office_9050.ppd":
		owner => "root",
		group => "_lp",
		mode => 644,
		source => "puppet:///files/psm_MJHS_Office_9050.ppd",
		ensure => present,
		require => Exec["mjhs_office_9050"],
	}

} # End of Class