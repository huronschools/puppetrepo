#/etc/puppet/manifests/classes/printers/printers_hhs_office9050.pp

class printers_hhs_office9050 {

	exec { "hhs_office9050":
		command => "/usr/sbin/lpadmin -p psm_HHS_Office_9050 -L HHS\\ Main\\ Office -D HHS\\ Main\\ Office\\ 9050\\ Copier -v lpd://10.13.1.8/HHS_Office_9050_Printer -P /Library/Printers/PPDs/Contents/Resources/HP\\ LaserJet\\ 9050.gz -E -o printer-is-shared=false",
		before => File["/etc/cups/ppd/psm_HHS_Office_9050.ppd"],
		unless => "/usr/bin/lpstat -a psm_HHS_Office_9050",
	}

	file { "/etc/cups/ppd/psm_HHS_Office_9050.ppd":
		owner => "root",
		group => "_lp",
		mode => 644,
		source => "puppet:///files/psm_HHS_Office_9050.ppd",
		ensure => present,
		require => Exec["hhs_office9050"],
	}

} # End of Class