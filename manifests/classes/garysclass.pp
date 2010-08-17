#/etc/puppet/manifests/classes/garysclass.pp

class garyclass {

	#  Includes
	include general_image
	include hslabs

	# Package Names
	$adobecs3 = "AdobeCS3.dmg"
	$finalcut = "FinalCut.dmg"
	$onepassword = "1Password-3.2.5.dmg"
	$dropbox = "Dropbox0.7.110.dmg"
	$echofon = "Echofon_1.0.4.dmg"
	$chrome = "googlechrome.dmg"
	$smugmug = "MacDaddy-3.0.4.510.dmg"
	$textmate = "TextMate_1.5.9.dmg"
	$growl = "Growl-1.2.1.dmg"
	$ard = "ARD_3.3.dmg"
	$istat = "istat304.dmg"
	$git = "git-1.7.2-intel-leopard.dmg"
	$cord = "cord.dmg"

	# Set Package resource defaults for OS X clients
	Package{ensure => installed,provider => pkgdmg}	

	# Install Specialized Packages
	package{"$finalcut": source => "$pkg_base/$finalcut"}
	package{"$adobecs3": source => "$pkg_base/$adobecs3"}
	package{"$istat": source => "$pkg_base/$istat"}
	package{"$git": source => "$pkg_base/$git"}
	package{"$ard": source => "$pkg_base/$ard"}
	package{"$cord": 
		source => "$pkg_base/$cord",
		provider => appdmg,
	}
	package{"$onepassword": 
		source => "$pkg_base/$onepassword",
		provider => appdmg,
	}
	package{"$dropbox": 
		source => "$pkg_base/$dropbox",
		provider => appdmg,
	}
	package{"$echofon": 
		source => "$pkg_base/$echofon",
		provider => appdmg,
	}
	package{"$chrome": 
		source => "$pkg_base/$chrome",
		provider => appdmg,
	}
	package{"$smugmug": 
		source => "$pkg_base/$smugmug",
		provider => appdmg,
	}
	package{"$textmate": 
		source => "$pkg_base/$textmate",
		provider => appdmg,
	}
	package{"$growl": source => "$pkg_base/$growl"}	
} # End of Class
