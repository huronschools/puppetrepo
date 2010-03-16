class developertools {

	Package{ensure => installed,provider => pkgdmg}

	# Package Names
	$devtools106 = "devtools313.dmg"
	$devtools105 = "developertools10.5.dmg"
	# Package Calls

	case $macosx_productversion_major {
		10.5: { 
			package{"$devtools105":
				source => "$pkg_base/$devtools10.5",
				}
		       }			
		10.6: { 
			package{"$devtools106":
				source => "$pkg_base/$devtools10.6",
	               	}
	}
} # End of Class
