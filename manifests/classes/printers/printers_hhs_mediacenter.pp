#/etc/puppet/manifests/classes/printers/printers_hhs_mediacenter.pp

class printers_hhs_mediacenter {

	exec { "hhs_mediacenter":
		command => "/usr/sbin/lpadmin -p psm_HHS_Media_Center -L HHS Media Center -D HHS Media Center Copier -v lpd://10.13.1.8/HHS_Media_Center_Copier -P /Library/Printers/PPDs/Contents/Resources/HP LaserJet 9050.gz -E -o printer-is-shared=false",
		before => File["/etc/cups/ppd/psm_HHS_Media_Center.ppd"],
		unless => "/usr/bin/lpstat -a psm_HHS_Media_Center",
	}

	file { "/etc/cups/ppd/psm_HHS_Media_Center.ppd":
		owner => "root",
		group => "_lp",
		mode => 644,
		source => "puppet:///files/psm_HHS_Media_Center.ppd",
		ensure => present,
		require => Exec["hhs_mediacenter"],
	}

} # End of Class