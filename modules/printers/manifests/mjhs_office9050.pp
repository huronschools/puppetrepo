# /etc/puppet/modules/printers/manifests/mjhs_office9050.pp

class printers::mjhs_office9050{
	require printers::params
	require printers::drivers
	
	$printer_name 			= $operatingsystem ? {
		darwin		=> "psm_MJHS_Office_9050",
		centos		=> "MJHS_Office_9050_Copier",
	}
	$printer_ppd			= "psm_MJHS_Office_9050.ppd"
	$printer_location 		= "MJHS Main Office"
	$printer_destination 	= "MJHS Main Office 9050 Copier"
	$lpd_ip 				= "lpd://10.13.2.7/Main_Office_9050_Copier"
	$options 				= "printer-is-shared=false"
	$printer_command 		= "/usr/sbin/lpadmin -p $printer_name -L '$printer_location' -D '$printer_destination' -v $lpd_ip -P '${printers::drivers::hp_lj9050_path}' -E -o $options"
	$printer_check 			= "/usr/bin/lpstat -a $printer_name"
	
	exec { "MJHS_Office_9050_Copier":
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
		require 	=> Exec["MJHS_Office_9050_Copier"],
	}
	
}