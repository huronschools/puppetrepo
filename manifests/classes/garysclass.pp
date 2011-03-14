#/etc/puppet/manifests/classes/garysclass.pp

class garyclass {

	# Things that don't install silently:
	# VMWare Fusion
	# 

	#  Includes
	include general
	include desktop
	include hslabs
	include developertools
	include printers_mjhs_mbcart01
	include printers_mjhs_mbcart02

	# Package Names
	$adobecs3 = "AdobeCS3.dmg"
	$pacifist = "Pacifist-2.6.4.dmg"
	$finalcut = "FinalCut.dmg"
	$onepassword = "1Password-3.2.5.dmg"
	$dropbox = "Dropbox-1.0.10.dmg"
	$echofon = "Echofon_1.0.4.dmg"
	$yorufukurou = "Yorufukurou.dmg"
	$gittower = "Git-tower.dmg"
	$chrome = "googlechrome.dmg"
	$smugmug = "MacDaddy-3.0.4.510.dmg"
	$textmate = "TextMate_1.5.9.dmg"
	$growl = "Growl-1.2.1.dmg"
	$ard = "ARD_3.3.dmg"
	$colloquy = "colloquy.dmg"
	$git = "git-1.7.2-intel-leopard.dmg"
	$cord = "cord.dmg"
	$smart = "smartboard101210.dmg"
	$finder = "finderrenamer.dmg"
	$droplr = "droplr-1.1.1.dmg"
	$adobereader = "AdbeRdr1000_en_US.dmg"

	# Install Specialized Packages
	package{"$finalcut": 
		source 		=> "$pkg_base/$finalcut",
	}
	notice($adobereader)
	package{"$adobereader": 
		source 		=> "$pkg_base/$adobereader",
	}
	package { "$droplr":
		source		=> "$pkg_base/$droplr",
		provider	=> appdmg,
	}
	package { "$pacifist":
		source		=> "$pkg_base/$pacifist",
		provider	=> appdmg,
	}
	package { "$gittower":
		source		=> "$pkg_base/$gittower",
		provider	=> appdmg,
	}
	package { "$yorufukurou":
		source		=> "$pkg_base/$yorufukurou",
		provider	=> appdmg,
	}
	package{"$finder": 
		source		 => "$pkg_base/$finder",
		provider	 => appdmg,
	}
	package{"$adobecs3": 
		source 		=> "$pkg_base/$adobecs3",
	}
	package{"$git": 
		source 		=> "$pkg_base/$git",
	}
	package{"$ard": 
		source		 => "$pkg_base/$ard",
	}
	package{"$smart": 
		source		 => "$pkg_base/$smart",
	}
	package{"$colloquy": 
		source		 => "$pkg_base/$colloquy",
		provider	 => appdmg,
	}
	package{"$cord": 
		source		 => "$pkg_base/$cord",
		provider 	 => appdmg,
	}
	package{"$onepassword": 
		source		 => "$pkg_base/$onepassword",
		provider	 => appdmg,
	}
	package{"$dropbox": 
		source		 => "$pkg_base/$dropbox",
		provider	 => appdmg,
	}
	package{"$echofon": 
		source		 => "$pkg_base/$echofon",
		provider	 => appdmg,
	}
	package{"$chrome": 
		source		 => "$pkg_base/$chrome",
		provider	 => appdmg,
	}
	package{"$smugmug": 
		source		 => "$pkg_base/$smugmug",
		provider	 => appdmg,
	}
	package{"$textmate": 
		source		 => "$pkg_base/$textmate",
		provider	 => appdmg,
	}
	package{"$growl": 
		source		 => "$pkg_base/$growl",
	}
} # End of Class
