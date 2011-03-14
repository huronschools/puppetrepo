# /etc/puppet/manifests/classes/wiscart01.pp
#

class wiscart01 {

	# Includes
	include general
	include desktopbackground
	include crankd
	include studentuser

	# Package Names
	$fastmath = "Fastmath.dmg"
	$flip4mac = "flip4mac.dmg"
	$arplugins = "arplugins.dmg"
	$dvdunlock = "dvdunlock.dmg"
	$keyskills = "keyskills.dmg"
	$ksapp = "keyskillsapp.dmg"
	$smart = "smartboard101210.dmg"

	# Set package resource defaults for OS X clients
	Package{ensure => installed,provider => pkgdmg}

	# Package Calls
	package{"$fastmath": source =>"$pkg_base/$fastmath",}
	package{"$smart": source => "$pkg_base/$smart"}
	package{"$flip4mac": source =>"$pkg_base/$flip4mac",}
	package{"$arplugins": source =>"$pkg_base/$arplugins",}
	package{"$dvdunlock": source =>"$pkg_base/$dvdunlock",}
	package{"$keyskills": 
		source =>"$pkg_base/$keyskills",
		before => Package[$ksapp],
		}
	package{"$ksapp": 
		source =>"$pkg_base/$ksapp",
		require => Package[$keyskills],
		provider => appdmg,
		}



} # End of Class

