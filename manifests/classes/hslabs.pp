#/etc/puppet/manifests/classes/hslabs.pp

class hslabs {

	# Includes
	include general_image
	include studentdata

	# Package Names
	$studio8 = "Studio8.dmg"
	$fmpro = "FilemakerPro.dmg"
	$keychainminder = "KeychainMinder.dmg"
	$alice = "Alice.dmg"
	$googleearth = "GoogleEarth.dmg"

	# Set Package resource defaults for OS X clients
	Package{ensure => installed,provider => pkgdmg}

	#Package Calls
	package{"$studio8": 
		source => "$pkg_base/$studio8",
		before => Exec[Dreamweaver Fix],
	}
	package{"$alice": source => "$pkg_base/$alice",}
	package{"$fmpro": source => "$pkg_base/$fmpro",}
	package{"$googleearth": source => "$pkg_base/$googleearth",}
	exec { "Dreamweaver Fix":
		command => "mv /Applications/Macromedia\ Dreamweaver\ 8/Dreamweaver\ 8/ /Applications/Macromedia\ Dreamweaver\ 8/Dreamweaver\ 8.app",
		creates => "/Applications/Macromedia\ Dreamweaver\ 8/Dreamweaver\ 8.app",
		require => Package[$studio8],
	}
	
	case $macosx_productversion_major {
		10.5: { 
			package{"$keychainminder": source => "$pkg_base/$keychainminder",}
		       }			
	}

} # End of Class
