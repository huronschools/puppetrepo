# /etc/puppet/modules/desktop/osx.pp

class desktop::osx {
	
	Package {ensure => installed, provider => pkgdmg}
	
	# Package Names
	$textwrangler = "TextWrangler_3.0.dmg"
	$firefox = "firefox3.6.11.dmg"
	$firstclass = "Firstclass20100621.dmg"
	$fcupdate = "firstclass10.013.dmg"
	$flash = "Flash10.1.dmg"
	$sophos = "sophos72810.dmg"
	$dnealian = "dnealian.dmg"
	$itunes = "iTunes10.1.2.dmg"
	
	# Package Calls
	package{"$itunes":
		source 	=> "$pkg_base/$itunes",
	}
	package{"$firstclass": 
		source 	=> "$pkg_base/$firstclass",
	}
	package{"$sophos": 
		source 	=> "$pkg_base/$sophos",
	}
	package{"$dnealian": 
		source 	=> "$pkg_base/$dnealian",
	}
	package{"$fcupdate": 
		source 		=> "$pkg_base/$fcupdate",
		provider	=> appdmg,
		require 	=> Package["$firstclass"],
	}
	package{"$textwrangler": 
		source 		=> "$pkg_base/$textwrangler",
		provider 	=> appdmg,
	}
	package{"$firefox": 
		source 		=> "$pkg_base/$firefox",
		provider 	=> appdmg,
	}
	
	case $macosx_productversion_major {
		10.5: { 
			include leopard
		       }			
		10.6: { 
			include snowleopard
	               }
		10.4: { 
			include tiger
		       }
	}

}
