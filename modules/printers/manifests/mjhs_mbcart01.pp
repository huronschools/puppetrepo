# /etc/puppet/modules/printers/manifests/mjhs_mbcart01.pp

class printers::mjhs_mbcart01{
	require printers::params
	require printers::drivers
	
	$printer_name 			= $operatingsystem ? {
		darwin		=> "psm_MJHS_Mbcart01",
		centos		=> "MJHS_Macbook_Cart_01_Printer",
	}
	$printer_location 		= "MJHS Macbook Cart 01"
	$printer_description 	= "MJHS Macbook Cart 01 Printer"
	$lpd_ip 				= "lpd://10.13.2.7/MMS_Macbook_Cart"
	$options 				= "printer-is-shared=false"
	$printer_command 		= "/usr/sbin/lpadmin -p $printer_name -L '$printer_location' -D '$printer_description' -v $lpd_ip -P '${printers::drivers::hp_lj4100_path}' -E -o $options"
	$printer_check 			= "/usr/bin/lpstat -a $printer_name"
	
	exec { "MJHS_Macbook_Cart_01_Printer":
		command 	=> "$printer_command",
		before 		=> File["/etc/cups/ppd/$printer_ppd"],
		unless 		=> "$printer_check",
	}
}