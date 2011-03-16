# /etc/puppet/modules/printers/manifests/shel_workroom.pp

class printers::shel_workroom{
	require printers::params
	require printers::drivers
	
	$shel_workroom_command = $operatingsystem ? {
		darwin		=> "/usr/sbin/lpadmin -p psm_SHEL_Workroom -L Shawnee\\ Staff\\ Workroom -D Shawnee\\ Workroom\\ Copier -v lpd://10.13.0.3/Shawnee_Workroom_Copier -P '${printers::drivers::hp_lj9040_path}' -E -o printer-is-shared=false",
		centos		=> "/usr/sbin/lpadmin -p Shawnee_Workroom_Copier -L Shawnee\\ Staff\\ Workroom -D Shawnee\\ Workroom\\ Copier -v lpd://10.13.0.3/Shawnee_Workroom_Copier -P ${printers::drivers::hp_lj9040_path} -E -o printer-is-shared=false"
	}
	
	$shel_workroom_check = $operatingsystem ? {
		darwin		=> "/usr/bin/lpstat -a psm_SHEL_Workroom",
		centos		=> "/usr/bin/lpstat -a Shawnee_Workroom_Copier"
	}
	
	exec { "Shawnee_Workroom_Copier":
		command 	=> "$shel_workroom_command",
		before 		=> File["/etc/cups/ppd/psm_SHEL_Workroom.ppd"],
		unless 		=> "$shel_workroom_check",
	}

	file { "/etc/cups/ppd/psm_SHEL_Workroom.ppd":
		owner 		=> "${printers::params::print_owner}",
		group 		=> "${printers::params::print_group}",
		mode 		=> 644,
		source 		=> "puppet:///printers/PPDs/psm_SHEL_Workroom.ppd",
		ensure 		=> present,
		require 	=> Exec["Shawnee_Workroom_Copier"],
	}
	
}