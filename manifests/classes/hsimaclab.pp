#/etc/puppet/manifests/classes/hsimaclab.pp

class hsimaclab {

	#  Includes
	include studentdata
	include hslabs
	include general_image

	# Package Names
	$shockwave = "shockwave.dmg"
	$flash = "flash10.dmg"
	$flip4mac = "flip4mac.dmg"
	$fireworks = "fireworks8.dmg"
	$googleearth = "GoogleEarth.dmg"

	# Install Required Packages First
	package{"$shockwave.dmg": source => "$pkg_base/$shockwave"}
	package{"$flash": source => "$pkg_base/$flash"}
	package{"$flip4mac": source => "$pkg_base/$flip4mac"}
	package{"$fireworks": source => "$pkg_base/$fireworks"}
	package{"$googleearth": source => "$pkg_base/$googleearth"}
} # End of Class
