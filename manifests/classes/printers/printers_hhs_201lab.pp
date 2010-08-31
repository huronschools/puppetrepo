#/etc/puppet/manifests/classes/printers/printers_hhs_201lab.pp

class printers_hhs_201lab {

	exec { "hhs_201lab":
		command => "/usr/sbin/lpadmin -p psm_HHS_201Lab -L HHS\\ Room\\ 201 -D HHS\\ Room\\ 201\\ Printer -v lpd://10.13.1.8/HHS_Room_201_Lab -P /Library/Printers/PPDs/Contents/Resources/HP\\ LaserJet\\ 4000\\ Series.gz -E -o printer-is-shared=false",
		unless => "/usr/bin/lpstat -a psm_HHS_201Lab",
	}

} # End of Class