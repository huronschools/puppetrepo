#/etc/puppet/manifests/classes/g5lab.pp

class g5lab {

	#  Includes
	include studentdata
	include general_image
	include hslabs
	include office2008
	include printers_hhs_g5labbw
	include printers_hhs_g5labcolor
	include loginhooks

	# Package Names
	$imagein = "ImageIn.dmg"
	$adobecs1 = "AdobeCS1.dmg"
	$hhsjfonts = "HHSJournalismFonts.dmg"
	$finalcut = "FinalCut.dmg"
	$hpscanjet = "HPScanjet.dmg"
	$audacityppc = "AudacityPPC.dmg"

	# Set Package resource defaults for OS X clients
	Package{ensure => installed,provider => pkgdmg}	

	# Install Specialized Packages
	package{"$hhsjfonts": source => "$pkg_base/$hhsjfonts",}
	package{"$finalcut": source => "$pkg_base/$finalcut",}
	package{"$hpscanjet": source => "$pkg_base/$hpscanjet",}
	package{"$audacityppc": source => "$pkg_base/$audacityppc",}
	package{"$imagein": 
		source => "$pkg_base/$imagein",
		require => Package[$adobecs1],
		}

	package{"$adobecs1":
		source => "$pkg_base/$adobecs1",
		before => Package[$imagein],
		}
		
	#Symlink fix for Illustrator
	file { "/Applications/Adobe Illustrator CS/Illustrator CS.app/Contents/Frameworks/AdobeSplashKit.framework/AdobeSplashKit": ensure => "/Applications/Adobe Illustrator CS/Illustrator CS.app/Contents/Frameworks/AdobeSplashKit.framework/Versions/A/AdobeSplashKit" }

} # End of Class
