# /etc/puppet/modules/printers/manifests/mjhs_mediacenter.pp

class printers::mjhs_mediacenter{
	require printers::params
	require printers::drivers
	
	$printer_name 			= $operatingsystem ? {
		darwin		=> "psm_MJHS_Media_Center",
		centos		=> "MJHS_Mediacenter_Copier",
	}
	$printer_ppd			= "psm_MJHS_Media_Center.ppd"
	$printer_location 		= "MJHS Media Center"
	$printer_destination 	= "MJHS Media Center Copier"
	$lpd_ip 				= "lpd://10.13.2.7/Media_Center_Copier"
	$options 				= "printer-is-shared=false"
	$printer_command 		= "/usr/sbin/lpadmin -p $printer_name -L '$printer_location' -D '$printer_destination' -v $lpd_ip -P '${printers::drivers::hp_lj9050_path}' -E -o $options"
	$printer_check 			= "/usr/bin/lpstat -a $printer_name"
	
	exec { "MJHS_Media_Center_Copier":
		command 	=> "$printer_command",
		before 		=> File["/etc/cups/ppd/$printer_ppd"],
		unless 		=> "$printer_check",
	}

	file { "/etc/cups/ppd/$printer_ppd":
		owner 		=> "${printers::params::print_owner}",
		group 		=> "${printers::params::print_group}",
		mode 		=> 644,
		source 		=> "puppet:///modules/printers/PPDs/$printer_ppd",
		ensure 		=> present,
		require 	=> Exec["MJHS_Media_Center_Copier"],
	}
	
}