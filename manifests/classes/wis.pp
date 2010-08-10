# /etc/puppet/manifests/classes/wis.pp

class wis {

	include wes_conf
	include printers_wis_office9050
	include printers_wis_officeworkroom

} # End of Class