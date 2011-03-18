# /etc/puppet/modules/printers/manifests/hhs_g5labcolor.pp

class printers::hhs_g5labcolor{
	require printers::params
	require printers::drivers
	
	$printer_name 			= $operatingsystem ? {
		darwin		=> "psm_HHS_G5_Color",
		centos		=> "HHS_G5_Lab_Color_Printer",
	}
	$printer_location 		= "HHS Room 99"
	$printer_description 	= "HHS G5 Lab Color Printer"
	$lpd_ip 				= "lpd://10.13.1.8/HHS_G5_Lab_Color_Printer"
	$options 				= "printer-is-shared=false"
	$printer_command 		= "/usr/sbin/lpadmin -p $printer_name -L '$printer_location' -D '$printer_description' -v $lpd_ip -P '${printers::drivers::hp_ljcp3505_path}' -E -o $options"
	$printer_check 			= "/usr/bin/lpstat -a $printer_name"
	
	exec { "HHS_G5_Lab_Color_Printer":
		command 	=> "$printer_command",
		before 		=> File["/etc/cups/ppd/$printer_ppd"],
		unless 		=> "$printer_check",
	}
}