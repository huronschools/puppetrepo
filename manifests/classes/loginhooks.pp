# /etc/puppet/manifests/classes/loginhooks.pp

class loginhooks {

	$hooks = "Enable_Hooks-20100914.dmg"
	Package{ensure => installed,provider => pkgdmg}
	package{"$hooks": source => "$pkg_base/$hooks",}

} # End of Class

