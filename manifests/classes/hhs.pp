# /etc/puppet/manifests/classes/hhs.pp

class hhs {

	include printers::hhs_mediacenter
	include printers::hhs_office9040
	include printers::hhs_office9050
	include printers::hhs_bookroom
	

} # End of Class