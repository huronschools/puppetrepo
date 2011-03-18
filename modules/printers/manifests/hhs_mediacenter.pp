# /etc/puppet/modules/printers/manifests/hhs_bookroom.pp

class printers::hhs_mediacenter{
	require printers::params
	require printers::drivers
	
	$printer_name 			= $operatingsystem ? {
		darwin		=> "psm_HHS_Media_Center",
		centos		=> "HHS_Mediacenter_Copier",
	}
	$printer_ppd			= "psm_HHS_Media_Center.ppd"
	$printer_location 		= "HHS Media Center"
	$printer_destination 	= "HHS Media Center Copier"
	$lpd_ip 				= "lpd://10.13.1.8/HHS_Media_Center_Copier"
	$options 				= "printer-is-shared=false"
	$printer_command 		= "/usr/sbin/lpadmin -p $printer_name -L '$printer_location' -D '$printer_destination' -v $lpd_ip -P '${printers::drivers::hp_lj9050_path}' -E -o $options"
	$printer_check 			= "/usr/bin/lpstat -a $printer_name"
	
	exec { "HHS_Media_Center_Copier":
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
		require 	=> Exec["HHS_Media_Center_Copier"],
	}
	
}