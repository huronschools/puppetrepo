#/etc/puppet/manifests/classes/printers/printers_shel_storage.pp

class printers_shel_storage {

	exec { "shel_storage":
		command => "/usr/sbin/lpadmin -p psm_SHEL_Storage -L Shawnee\\ Staff\\ Storage -D Shawnee\\ Storage\\ Copier -v lpd://10.13.0.3/Shawnee_Storage_Copier -P /Library/Printers/PPDs/Contents/Resources/HP\\ LaserJet\\ 9040.gz -E -o printer-is-shared=false",
		before => File["/etc/cups/ppd/psm_SHEL_Storage.ppd"],
		unless => "/usr/bin/lpstat -a psm_SHEL_Storage",
	}

	file { "/etc/cups/ppd/psm_SHEL_Storage.ppd":
		owner => "root",
		group => "_lp",
		mode => 644,
		source => "puppet:///files/psm_SHEL_Storage.ppd",
		ensure => present,
		require => Exec["shel_storage"],
	}

} # End of Class