# /etc/puppet/modules/printers/manifests/hhs_201lab.pp

class printers::hhs_201lab{
	require printers::params
	require printers::drivers
	
	$printer_name 			= $operatingsystem ? {
		darwin		=> "psm_HHS_201Lab",
		centos		=> "HHS_Room_201_Printer",
	}
	$printer_location 		= "HHS Room 201"
	$printer_description 	= "HHS Room 201 Printer"
	$lpd_ip 				= "lpd://10.13.1.8/HHS_Room_201_Lab"
	$options 				= "printer-is-shared=false"
	$printer_command 		= "/usr/sbin/lpadmin -p $printer_name -L '$printer_location' -D '$printer_description' -v $lpd_ip -P '${printers::drivers::hp_lj4250_path}' -E -o $options"
	$printer_check 			= "/usr/bin/lpstat -a $printer_name"
	
	exec { "HHS_Room_201_Lab_Printer":
		command 	=> "$printer_command",
		before 		=> File["/etc/cups/ppd/$printer_ppd"],
		unless 		=> "$printer_check",
	}
}