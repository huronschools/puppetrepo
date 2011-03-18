# /etc/puppet/modules/printers/manifests/hhs_office9040.pp

class printers::hhs_office9040{
	require printers::params
	require printers::drivers
	
	$printer_name 			= $operatingsystem ? {
		darwin		=> "psm_HHS_Office_9040",
		centos		=> "HHS_Office_Fax_Copier",
	}
	$printer_ppd			= "psm_HHS_Office_9040.ppd"
	$printer_location 		= "HHS Main Office"
	$printer_destination 	= "HHS Main Office Fax Copier"
	$lpd_ip 				= "lpd://10.13.1.8/HHS_Office_9040_Fax_Printer"
	$options 				= "printer-is-shared=false"
	$printer_command 		= "/usr/sbin/lpadmin -p $printer_name -L '$printer_location' -D '$printer_destination' -v $lpd_ip -P '${printers::drivers::hp_lj9040_path}' -E -o $options"
	$printer_check 			= "/usr/bin/lpstat -a $printer_name"
	
	exec { "HHS_Main_Office_Fax_Copier":
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
		require 	=> Exec["HHS_Main_Office_Fax_Copier"],
	}
}