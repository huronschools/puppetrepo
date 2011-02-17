# /etc/puppet/manifests/classes/general_image.pp

class general_image {

	# Includes
	include mcollective
	include puppet_config
	
	# Package Names
	$facter = "facter-1.5.8.dmg"
	$puppetcurrent = "puppet-2.6.4.dmg"
	$textwrangler = "TextWrangler_3.0.dmg"
	$firefox = "firefox3.6.11.dmg"
	$firstclass = "Firstclass20100621.dmg"
	$fcupdate = "firstclass10.013.dmg"
	$flash = "Flash10.1.dmg"
	$sophos = "sophos72810.dmg"
	$dnealian = "dnealian.dmg"
	$itunes = "iTunes10.1.2.dmg"
	
	# Package Calls
	package{"$facter": 
		source 	=> "$pkg_base/$facter",
		before	=> Package["$puppetcurrent"],
	}
	package{"$puppetcurrent":
		source 	=> "$pkg_base/$puppetcurrent",
	}	
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
	
	# MCollective Facts
	file { "/etc/mcollective/facts.yaml":
		ensure 		=> file,
		content		=> inline_template("<%= facts = {}; scope.to_hash.each_pair {|k,v| facts[k.to_s] = v.to_s}; facts.to_yaml %>"),
		#content 	=> inline_template("<%= scope.to_hash.reject { |k,v| !( k.is_a?(String) && v.is_a?(String) ) }.to_yaml %>"),
		before		=> Service["com.huronhs.mcollective"],
		require		=> Package["$mcollective"],
		notify		=> Service["com.huronhs.mcollective"],
	}

} # End of Class
