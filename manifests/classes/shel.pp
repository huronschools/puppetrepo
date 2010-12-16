# /etc/puppet/manifests/classes/shel.pp

class shel {

	include printers_shel_workroom
	include printers_shel_storage

} # End of Class