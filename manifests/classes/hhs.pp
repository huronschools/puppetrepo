# /etc/puppet/manifests/classes/hhs.pp

class hhs {

	include hhs_conf
	include printers_hhs_mediacenter
	

} # End of Class