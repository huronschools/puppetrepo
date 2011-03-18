# /etc/puppet/manifests/classes/mjhs.pp

class mjhs {

	include printers::mjhs_mediacenter
	include printers::mjhs_office9040
	include printers::mjhs_office9050

} # End of Class