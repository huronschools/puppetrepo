# /etc/puppet/manifests/classes/loginhooks.pp

class loginhooks {

	$hooks = "Enable_Hooks-20100914.dmg"
	
	package{"$hooks": 
		source => "$pkg_base/$hooks",
		before => File["/etc/hooks/LICachesRedirect.hook"],
		ensure => installed,
		provider => pkgdmg,
		}
	file { "/etc/hooks/LICachesRedirect.hook":
		ensure => file,
		require => Package["$hooks"],
		owner => "root",
		group => "admin",
		mode => 755,
		source => "puppet:///files/Loginhooks/LICachesRedirect.hook",
	}
	file { "/etc/hooks/LILogger.hook":
		ensure => file,
		require => Package["$hooks"],
		owner => "root",
		group => "admin",
		mode => 755,
		source => "puppet:///files/Loginhooks/LILogger.hook",
	}
	file { "/etc/hooks/LOLogger.hook":
		ensure => file,
		require => Package["$hooks"],
		owner => "root",
		group => "admin",
		mode => 755,
		source => "puppet:///files/Loginhooks/LOLogger.hook",
	}
	
	

} # End of Class

