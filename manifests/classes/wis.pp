# /etc/puppet/manifests/classes/wis.pp

class wis {

	include printers_wis_office9050
	include printers_wis_officeworkroom
	include printers_wis_wing2
	include printers_wis_wing1
	include printers_wis_computerlab

} # End of Class

class wes {

	include printers_wis_office9050
	include printers_wis_officeworkroom
	include printers_wis_wing2
	include printers_wis_wing1
	include printers_wis_computerlab

} # End of Class