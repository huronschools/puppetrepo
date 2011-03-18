# /etc/puppet/modules/printers/manifests/hhs_g5labbw.pp

class printers::hhs_g5labbw{
	require printers::params
	require printers::drivers
	
	$printer_name 			= $operatingsystem ? {
		darwin		=> "psm_HHS_G5_BW",
		centos		=> "HHS_G5_Lab_BW_Printer",
	}
	$printer_location 		= "HHS Room 99"
	$printer_description 	= "HHS G5 Lab Black and White Printer"
	$lpd_ip 				= "lpd://10.13.1.8/HHS_G5_Lab_BW_Printer"
	$options 				= "printer-is-shared=false"
	$printer_command 		= "/usr/sbin/lpadmin -p $printer_name -L '$printer_location' -D '$printer_description' -v $lpd_ip -P '${printers::drivers::hp_lj4250_path}' -E -o $options"
	$printer_check 			= "/usr/bin/lpstat -a $printer_name"
	
	exec { "HHS_G5_Lab_BW_Printer":
		command 	=> "$printer_command",
		before 		=> File["/etc/cups/ppd/$printer_ppd"],
		unless 		=> "$printer_check",
	}
}
