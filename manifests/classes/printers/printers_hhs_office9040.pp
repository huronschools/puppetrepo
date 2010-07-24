#/etc/puppet/manifests/classes/printers/printers_hhs_office9040.pp

class printers_hhs_office9040 {

	exec { "hhs_office9040":
		command => "/usr/sbin/lpadmin -p psm_HHS_Office_9040 -L HHS\\ Main\\ Office\\ -D HHS\\ Main\\ Office\\ Fax\\ Copier -v lpd://10.13.1.8/HHS_Office_Fax_Printer -P /Library/Printers/PPDs/Contents/Resources/HP\\ LaserJet\\ 9040.gz -E -o printer-is-shared=false",
		before => File["/etc/cups/ppd/psm_HHS_Office_9040.ppd"],
		unless => "/usr/bin/lpstat -a psm_HHS_Office_9040",
	}

	file { "/etc/cups/ppd/psm_HHS_Office_9040.ppd":
		owner => "root",
		group => "_lp",
		mode => 644,
		source => "puppet:///files/psm_HHS_Office_9040.ppd",
		ensure => present,
		require => Exec["hhs_office9040"],
	}

} # End of Class