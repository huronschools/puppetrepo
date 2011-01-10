class developertools {

	# Package Names
	$devtools106 = "DeveloperTools322.dmg"
	$devtools105 = "developertools10.5.dmg"


	case $macosx_productversion_major {
		10.5: { 
			package{"$devtools105":
				source => "$pkg_base/$devtools105",
			}
		}			
		10.6: { 
			package{"$devtools106":
				source => "$pkg_base/$devtools106",
			}
		}
	}
} # End of Class
