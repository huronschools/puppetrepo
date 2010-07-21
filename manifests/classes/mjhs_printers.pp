#/etc/puppet/manifests/classes/mjhs_printers.pp

class mjhs_printers {

	exec { "/var/db/printers directory":
		command => "mkdir -p /var/db/printers",
		before => Exec["mjhs_office_9050"],
		creates => "/var/db/printers",
		#refreshonly => true,
	}

	exec { "mjhs_office_9050":
		command => "/usr/sbin/lpadmin -p psm_MJHS_Office_9050 -L MJHS\ Office -D MJHS\ Main\ Office\ 9050\ Copier -v lpd://10.13.2.7/Main_Office_9050_Copier -P /Library/Printers/PPDs/Contents/Resources/HP\ LaserJet\ 9050.gz -E -o printer-is-shared=false",
		creates => "/var/db/printers/psm_MJHS_Office_9050.mjhs",
		before => File["/etc/cups/ppd/psm_MJHS_Office_9050.ppd"]
		#refreshonly => true,
	}
	
	file { "/etc/cups/ppd/psm_MJHS_Office_9050.ppd":
		owner => "root",
		group => "_lp",
		mode => 644,
		source => "puppet:///files/psm_MJHS_Office_9050.ppd",
		ensure => present,
	}

} # End of Class