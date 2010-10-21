# /etc/puppet/manifests/classes/boe.pp

class boe {

	include boe_conf
	include printers_boe_edgeline

} # End of Class