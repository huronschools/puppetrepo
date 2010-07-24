#/etc/puppet/manifests/classes/printers/printers_hhs_g5labcolor.pp

class printers_mjhs_imaclabcolor {

	exec { "hhs_g5lab_color":
		command => "/usr/sbin/lpadmin -p psm_HHS_G5_Color -L HHS\\ Room\\ 099 -D HHS\\ G5\\ Lab\\ Color\\ Printer -v lpd://10.13.1.8/HHS_G5_Lab_Color_Printer -P /Library/Printers/PPDs/Contents/Resources/HP\\ Color\\ LaserJet\\ CP3505.gz -E -o printer-is-shared=false",
		unless => "/usr/bin/lpstat -a psm_HHS_G5_Color",
		require => File["/Library/Printers/PPDs/Contents/Resources/HP Color LaserJet CP3505.gz"],
	}

	file { "/Library/Printers/PPDs/Contents/Resources/HP Color LaserJet CP3505.gz":
		owner => "root",
		group => "admin",
		mode => 664,
		source => "puppet:///files/HP Color LaserJet CP3505.gz",
		ensure => present,
		before => Exec["hhs_g5lab_color"],
		replace => false,
	}

} # End of Class