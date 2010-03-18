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
	$officeconfig = "Office2008Config.dmg"
	$officestudent = "Office2008Studentconfig.dmg"
	$officesave = "Office2008Savesettings.dmg"
	
	# Set Package resource defaults for OS X clients
	#Package{ensure => installed,provider => pkgdmg}

	# Package Calls
	package{"$office": 
		source => "$pkg_base/$office",
		}
        package{"$officeconfig":
                source => "$pkg_base/$officeconfig",
                before => Package[$officestudent],
                require => Package[$office],
                } 	
	package{"$officestudent":
		source => "$pkg_base/$officestudent",
		before => Package[$officesave],
		require => Package[$officeconfig],
		}
	package{"$officesave":
		source => "$pkg_base/$officesave",
		before => Package[$update1220],
		require => Package[$officestudent],
	}
	package{"$update1220":
                source => "$pkg_base/$update1220",
                require => Package[$office],
                before => Package[$update1223],
                }
	package{"$update1223":
                source => "$pkg_base/$update1223",
                require => Package[$update1220],
                before => Package[$update1224],
                }
	package{"$update1224":
                source => "$pkg_base/$update1224",
                require => Package[$update1223],
                }

}

