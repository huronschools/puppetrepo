# /etc/puppet/manifests/classes/shawlabs.pp
#

class shawlabs {

	# Includes
	include general_image

	# Package Names
	$fastmath = "Fastmath.dmg"
	$flash = "flash10.0.45.2.dmg"
	$flip4mac = "flip4mac.dmg"
	$shockwave = "shockwave11.5.dmg"
	$arplugins = "arplugins.dmg"
	$dvdunlock = "dvdunlock.dmg"
	$keyskills = "keyskills.dmg"
	$ksapp = "keyskillsapp.dmg"
	$rosetta = "Rosetta.dmg"

	# Set package resource defaults for OS X clients
	Package{ensure => installed,provider => pkgdmg}

	# Package Calls
	package{"$fastmath": source =>"$pkg_base/$fastmath",}
	package{"$flash": source =>"$pkg_base/$flash",}
	package{"$flip4mac": source =>"$pkg_base/$flip4mac",}
	package{"$shockwave": source =>"$pkg_base/$shockwave",}
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

	case $macosx_productversion_major {
		10.6: { 
			package{"$rosetta": source =>"$pkg_base/$rosetta",}
	               }
	}

} # End of Class

