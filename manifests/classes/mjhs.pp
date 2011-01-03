# /etc/puppet/manifests/classes/mjhs.pp

class mjhs {

	include printers_mjhs_mediacenter
	include printers_mjhs_office9040
	include printers_mjhs_office9050

} # End of Class