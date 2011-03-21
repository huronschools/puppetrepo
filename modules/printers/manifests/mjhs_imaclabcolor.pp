# /etc/puppet/modules/printers/manifests/mjhs_imaclabcolor.pp

class printers::mjhs_imaclabcolor{
	require printers::params
	require printers::drivers
	
	$printer_name 			= $operatingsystem ? {
		darwin		=> "psm_MJHS_Lab_Color",
		centos		=> "MJHS_iMac_Lab_Color_Printer",
	}
	$printer_location 		= "MJHS iMac Lab"
	$printer_description 	= "MJHS iMac Lab Color Printer"
	$lpd_ip 				= "lpd://10.13.2.7/iMac_Lab_Color_Printing"
	$options 				= "printer-is-shared=false"
	$printer_command 		= "/usr/sbin/lpadmin -p $printer_name -L '$printer_location' -D '$printer_description' -v $lpd_ip -P '${printers::drivers::hp_ljcp3505_path}' -E -o $options"
	$printer_check 			= "/usr/bin/lpstat -a $printer_name"
	
	exec { "MJHS_iMac_Lab_Color_Printer":
		command 	=> "$printer_command",
		unless 		=> "$printer_check",
	}
}