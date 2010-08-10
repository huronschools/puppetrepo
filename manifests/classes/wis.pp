# /etc/puppet/manifests/classes/wis.pp

class wis {

	include wes_conf
	include printers_wis_office9050

} # End of Class