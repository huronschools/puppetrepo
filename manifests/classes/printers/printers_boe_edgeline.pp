#/etc/puppet/manifests/classes/printers/printers_boe_edgeline.pp

class printers_boe_edgeline {

	exec { "boe_edgeline":
		command => "/usr/sbin/lpadmin -p psm_BOE_Edgeline -L BOE\\ Office -D BOE\\ Office\\ Copier -v lpd://10.13.0.3/BOE_HP_Copier -P /Library/Printers/PPDs/Contents/Resources/HP\\ CM8050\\ CM8060\\ MFP.gz -E -o printer-is-shared=false",
		unless => "/usr/bin/lpstat -a psm_BOE_Edgeline",
		require => File["/Library/Printers/PPDs/Contents/Resources/HP CM8050 CM8060 MFP.gz"],
	}

	file { "/Library/Printers/PPDs/Contents/Resources/HP CM8050 CM8060 MFP.gz":
		owner => "root",
		group => "admin",
		mode => 664,
		source => "puppet:///files/HP CM8050 CM8060 MFP.gz",
		ensure => present,
		before => Exec["boe_edgeline"],
		replace => false,
	}

} # End of Class