# /etc/puppet/modules/printers/manifests/mjhs_imaclabbw.pp

class printers::mjhs_imaclabbw{
	require printers::params
	require printers::drivers
	
	$printer_name 			= $operatingsystem ? {
		darwin		=> "psm_MJHS_Lab_BW",
		centos		=> "MJHS_iMac_Lab_BW_Printer",
	}
	$printer_location 		= "MJHS iMac Lab"
	$printer_description 	= "MJHS iMac Lab BW Printer"
	$lpd_ip 				= "lpd://10.13.2.7/iMac_Lab_BW_Printer"
	$options 				= "printer-is-shared=false"
	$printer_command 		= "/usr/sbin/lpadmin -p $printer_name -L '$printer_location' -D '$printer_description' -v $lpd_ip -P '${printers::drivers::hp_lj4200_path}' -E -o $options"
	$printer_check 			= "/usr/bin/lpstat -a $printer_name"
	
	exec { "MJHS_iMac_Lab_BW_Printer":
		command 	=> "$printer_command",
		unless 		=> "$printer_check",
	}
}