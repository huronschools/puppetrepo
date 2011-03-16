#/etc/puppet/modules/printers/shel_storage.pp

class printers::shel_storage {
	require printers::params
	require printers::drivers

	$shel_storage_command = $operatingsystem ? {
		darwin		=> "/usr/sbin/lpadmin -p psm_SHEL_Storage -L Shawnee\\ Staff\\ Storage -D Shawnee\\ Storage\\ Copier -v lpd://10.13.0.3/Shawnee_Storage_Copier -P '${printers::drivers::hp_lj9040_path}' -E -o printer-is-shared=false",
		centos		=> "/usr/sbin/lpadmin -p Shawnee_Storage_Copier -L Shawnee\\ Staff\\ Storage -D Shawnee\\ Storage\\ Copier -v lpd://10.13.0.3/Shawnee_Storage_Copier -P ${printers::drivers::hp_lj9040_path} -E -o printer-is-shared=false",
	}
	
	$shel_storage_check = $operatingsystem ? {
		darwin		=> "/usr/bin/lpstat -a psm_SHEL_Storage",
		centos		=> "/usr/bin/lpstat -a Shawnee_Storage_Copier",
	}
	
	exec { "Shawnee_Storage_Copier":
		command 	=> "$shel_storage_command",
		before 		=> File["/etc/cups/ppd/psm_SHEL_Storage.ppd"],
		unless 		=> "$shel_storage_check",
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