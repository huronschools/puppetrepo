#/etc/puppet/manifests/classes/printers/printers_wis_computerlab.pp

class printers_wis_computerlab {

	exec { "wis_computerlab":
		command => "/usr/sbin/lpadmin -p psm_WIS_Computerlab -L Computer\\ Lab -D Woodlands\\ Computer\\ Lab\\ Copier -v lpd://10.13.3.8/WES_Computer_Lab_Copier -P /Library/Printers/PPDs/Contents/Resources/HP\\ LaserJet\\ 9040.gz -E -o printer-is-shared=false",
		before => File["/etc/cups/ppd/psm_WIS_Computerlab.ppd"],
		unless => "/usr/bin/lpstat -a psm_WIS_Computerlab",
	}

	file { "/etc/cups/ppd/psm_WIS_Computerlab.ppd":
		owner => "root",
		group => "_lp",
		mode => 644,
		source => "puppet:///files/psm_WIS_Computerlab.ppd",
		ensure => present,
		require => Exec["wis_computerlab"],
	}

} # End of Class