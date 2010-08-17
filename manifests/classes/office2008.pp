# /etc/puppet/manifests/classes/office2008.pp
#
#  Microsoft Office 2008 and all current Updates.
#

class office2008 {

	# Package Names
	$office = "Office2008.dmg"
	$update1210 = "Office2008-1210UpdateEN.dmg"
	$update1220 = "Office2008-1220UpdateEN.dmg"
	$update1223 = "Office2008-1223UpdateEN.dmg"
	$update1224 = "Office2008-1224UpdateEN.dmg"
	$update1226 = "Office2008-1226UpdateEN.dmg"
	
	# Set Package resource defaults for OS X clients
	#Package{ensure => installed,provider => pkgdmg}

	# Package Calls
	package{"$office": 
		source => "$pkg_base/$office",
		}
	package{"$update1220":
                source => "$pkg_base/$update1220",
                require => Package[$office],
                before => Package[$update1223],
                }
	package{"$update1226":
                source => "$pkg_base/$update1226",
                require => Package[$update1220],
                }

}

