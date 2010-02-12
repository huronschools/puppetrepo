#/etc/puppet/manifests/classes/hsimaclab.pp

class hsimaclab {

	#  Includes
	include studentdata
	include hslabs
	include general_image
	include desktopbackground
#	include studentuser

	# Package Names
	$shockwave = "shockwave.dmg"
	$flash = "flash10.dmg"
	$flip4mac = "flip4mac.dmg"
	$fireworks = "fireworks8.dmg"

	# Install Required Packages First
	package{"$shockwave": source => "$pkg_base/$shockwave"}
	package{"$flash": source => "$pkg_base/$flash"}
	package{"$flip4mac": source => "$pkg_base/$flip4mac"}
	package{"$fireworks": source => "$pkg_base/$fireworks"}

} # End of Class
