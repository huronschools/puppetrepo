# /etc/puppet/manifests/classes/shel.pp

class shel {

	include boe_conf
	include printers_shel_workroom

} # End of Class