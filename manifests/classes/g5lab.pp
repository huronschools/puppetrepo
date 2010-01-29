#/etc/puppet/manifests/classes/g5lab.pp

class g5lab {

	#  Includes
	include studentdata
	include general_image
	include hslabs

	# Package Names
	$imagein = "ImageIn.dmg"
	$adobecs1 = "AdobeCS1.dmg"
	$hhsjfonts = "HHSJournalismFonts.dmg"
	$finalcut = "FinalCut.dmg"

	# Set Package resource defaults for OS X clients
	Package{ensure => installed,provider => pkgdmg}	

	# Install Specialized Packages
	package{"$hhsjfonts": source => "$pkg_base/$hhsjfonts",}
	package{"$finalcut": source => "$pkg_base/$finalcut",}

	package{"$imagein": 
		source => "$pkg_base/$imagein",
		require => Package[$adobecs1],
		}

	package{"$adobecs1":
		source => "$pkg_base/$adobecs1",
		before => Package[$imagein],
		}
} # End of Class
