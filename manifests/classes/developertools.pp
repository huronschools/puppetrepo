class developertools {

	Package{ensure => installed,provider => pkgdmg}

	# Package Names
	$devtools10.6 = "devtools313.dmg"
	$devtools10.5 = "developertools10.5.dmg"
	# Package Calls

	case $macosx_productversion_major {
		10.5: { 
			package{"$devtools10.5":
				source => "$pkg_base/$devtools10.5",
				}
		       }			
		10.6: { 
			package{"$devtools10.6":
				source => "$pkg_base/$devtools10.6",
	               	}
	}
} # End of Class
