#/etc/puppet/manifests/classes/printers/printers_hhs_bookroom.pp

class printers_hhs_bookroom {

	exec { "hhs_bookroom":
		command => "/usr/sbin/lpadmin -p psm_HHS_Bookroom -L HHS\\ Book\\ Room -D HHS\\ Bookroom\\ Copier -v lpd://10.13.1.8/HHS_Book_Room_Copier -P /Library/Printers/PPDs/Contents/Resources/HP\\ LaserJet\\ 9040.gz -E -o printer-is-shared=false",
		before => File["/etc/cups/ppd/psm_HHS_Bookroom.ppd"],
		unless => "/usr/bin/lpstat -a psm_HHS_Bookroom",
	}

	file { "/etc/cups/ppd/psm_HHS_Bookroom.ppd":
		owner => "root",
		group => "_lp",
		mode => 644,
		source => "puppet:///files/psm_HHS_Bookroom.ppd",
		ensure => present,
		require => Exec["hhs_bookroom"],
	}

} # End of Class