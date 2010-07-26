#/etc/puppet/manifests/classes/printers/printers_shel_workroom.pp

class printers_shel_workroom {

	exec { "shel_workroom":
		command => "/usr/sbin/lpadmin -p psm_SHEL_Workroom -L Shawnee\\ Staff\\ Workroom -D Shawnee\\ Workroom\\ Copier -v lpd://10.13.0.3/Shawnee_Workroom_Copier -P /Library/Printers/PPDs/Contents/Resources/HP\\ LaserJet\\ 9040.gz -E -o printer-is-shared=false",
		before => File["/etc/cups/ppd/psm_SHEL_Workroom.ppd"],
		unless => "/usr/bin/lpstat -a psm_SHEL_Workroom",
	}

	file { "/etc/cups/ppd/psm_SHEL_Workroom.ppd":
		owner => "root",
		group => "_lp",
		mode => 644,
		source => "puppet:///files/psm_SHEL_Workroom.ppd",
		ensure => present,
		require => Exec["shel_workroom"],
	}

} # End of Class