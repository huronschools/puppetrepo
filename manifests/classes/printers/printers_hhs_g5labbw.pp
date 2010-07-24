#/etc/puppet/manifests/classes/printers/printers_hhs_g5labbw.pp

class printers_hhs_g5labbw {

	exec { "hhs_g5lab_bw":
		command => "/usr/sbin/lpadmin -p psm_HHS_G5_BW -L HHS\\ Room\\ 099 -D HHS\\ G5\\ Lab\\ Black\\ and\\ White\\ Printer -v lpd://10.13.1.8/HHS_G5_Lab_BW_Printer -P /Library/Printers/PPDs/Contents/Resources/HP\\ LaserJet\\ 4200\\ Series.gz -E -o printer-is-shared=false",
		unless => "/usr/bin/lpstat -a psm_HHS_G5_BW",
		require => File["/Library/Printers/PPDs/Contents/Resources/HP LaserJet 4200 Series.gz"],
	}

	file { "/Library/Printers/PPDs/Contents/Resources/HP LaserJet 4200 Series.gz":
		owner => "root",
		group => "admin",
		mode => 664,
		source => "puppet:///files/HP LaserJet 4200 Series.gz",
		ensure => present,
		before => Exec["hhs_g5lab_bw"],
		replace => false,
	}

} # End of Class