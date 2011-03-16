# /etc/puppet/manifests/classes/shel.pp

class shel {

	include printers::shel_workroom
	include printers::shel_storage

} # End of Class