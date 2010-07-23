#/etc/puppet/manifests/classes/printers/printers_mjhs_imaclabcolor.pp

class printers_mjhs_imaclabcolor {

	exec { "mjhs_imaclab_color":
		command => "/usr/sbin/lpadmin -p psm_MJHS_Lab_Color -L MJHS\\ Computer\\ Lab -D MJHS\\ Lab\\ Color\\ Printer -v lpd://10.13.2.7/iMac_Lab_Color_Printer -P /Library/Printers/PPDs/Contents/Resources/HP\\ Color\\ LaserJet\\ CP3505.gz -E -o printer-is-shared=false",
		unless => "/usr/bin/lpstat -a psm_MJHS_Lab_Color",
		require => File["/Library/Printers/PPDs/Contents/Resources/HP Color LaserJet CP3505.gz"],
	}

	file { "/Library/Printers/PPDs/Contents/Resources/HP Color LaserJet CP3505.gz":
		owner => "root",
		group => "admin",
		mode => 664,
		source => "puppet:///files/HP Color LaserJet CP3505.gz",
		ensure => present,
		before => Exec["mjhs_imaclab_color"],
		replace => false,
	}

} # End of Class