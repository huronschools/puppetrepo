#/etc/puppet/modules/printers/shel_storage.pp

class printers::shel_storage {
	require printers::params
	require printers::drivers
	
	$printer_name = $operatingsystem ? {
		darwin		=> "psm_SHEL_Storage",
		centos		=> "Shawnee_Storage_Copier",
	}
	$printer_location = "Shawnee\\ Staff\\ Storage"
	$printer_destination = "Shawnee\\ Storage\\ Copier"
	$lpd_ip = "lpd://10.13.0.3/Shawnee_Storage_Copier"
	$options = "printer-is-shared=false"
	$printer_command = "/usr/sbin/lpadmin -p $printer_name -L $printer_location -D $printer_destination -v $lpd_ip -P '${printers::drivers::hp_lj9040_path}' -E -o $options"
	$printer_check = "/usr/bin/lpstat -a $printer_name"
	
	exec { "Shawnee_Storage_Copier":
		command 	=> "$printer_command",
		before 		=> File["/etc/cups/ppd/psm_SHEL_Storage.ppd"],
		unless 		=> "$printer_check",
	}

	file { "/etc/cups/ppd/psm_SHEL_Storage.ppd":
		owner 		=> "${printers::params::print_owner}",
		group 		=> "${printers::params::print_group}",
		mode 		=> 644,
		source	 	=> "puppet:///printers/PPDs/psm_SHEL_Storage.ppd",
		ensure 		=> present,
		require		=> Exec["Shawnee_Storage_Copier"],
	}
	
}