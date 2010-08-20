# /etc/puppet/manifests/classes/hhs.pp

class hhs {

	include hhs_conf
	include printers_hhs_mediacenter
	include printers_hhs_office9040
	include printers_hhs_office9050
	include printers_hhs_bookroom
	

} # End of Class