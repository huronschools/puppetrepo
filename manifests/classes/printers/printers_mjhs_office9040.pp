#/etc/puppet/manifests/classes/printers/printers_mjhs_office9040.pp

class printers_mjhs_office9040 {

	exec { "mjhs_office_9040":
		command => "/usr/sbin/lpadmin -p psm_MJHS_Office_9040 -L MJHS\\ Office -D MJHS\\ Main\\ Office\\ 9040\\ Fax\\ Copier -v lpd://10.13.2.7/Main_Office_9040_Fax_Copier -P /Library/Printers/PPDs/Contents/Resources/HP\\ LaserJet\\ 9040.gz -E -o printer-is-shared=false",
		before => File["/etc/cups/ppd/psm_MJHS_Office_9040.ppd"],
		unless => "/usr/bin/lpstat -a psm_MJHS_Office_9040",
	}

	file { "/etc/cups/ppd/psm_MJHS_Office_9040.ppd":
		owner => "root",
		group => "_lp",
		mode => 644,
		source => "puppet:///files/psm_MJHS_Office_9040.ppd",
		ensure => present,
		require => Exec["mjhs_office_9040"],
	}

} # End of Class