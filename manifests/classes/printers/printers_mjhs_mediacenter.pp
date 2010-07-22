#/etc/puppet/manifests/classes/printers/printers_mjhs_mediacenter.pp

class printers_mjhs_mediacenter {

	exec { "mjhs_mediacenter":
		command => "/usr/sbin/lpadmin -p psm_MJHS_Media_Center -L MJHS\ Media\ Center -D MJHS\ Media\ Center Copier -v lpd://10.13.2.7/Media_Center_Copier -P /Library/Printers/PPDs/Contents/Resources/HP\ LaserJet\ 9050.gz -E -o printer-is-shared=false",
		before => File["/etc/cups/ppd/psm_MJHS_Media_Center.ppd"],
		unless => "/usr/bin/lpstat -a psm_MJHS_Media_Center",
	}

	file { "/etc/cups/ppd/psm_MJHS_Media_Center.ppd":
		owner => "root",
		group => "_lp",
		mode => 644,
		source => "puppet:///files/psm_MJHS_Media_Center.ppd",
		ensure => present,
		require => Exec["mjhs_mediacenter"],
	}

} # End of Class