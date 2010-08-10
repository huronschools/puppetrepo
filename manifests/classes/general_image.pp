# /etc/puppet/manifests/classes/general_image.pp

class general_image {

	# Includes
	include staff
	include puppet_LaunchDaemon
	
	# Package Names
	$facter = "facter.1.5.7.dmg"
	$puppetcurrent = "puppet-0.25.5.dmg"
	$textwrangler = "TextWrangler_3.0.dmg"
	$ard = "ardalllocal.dmg"
	$firefox = "Firefox3.6.dmg"
	$firstclass = "Firstclass20100621.dmg"
	$flash = "Flash10.1.dmg"
	$sophos = "sophos72810.dmg"
	$dnealian = "dnealian.dmg"

	# Set Package resource defaults for OS X clients
	Package{ensure => installed,provider => pkgdmg}
	
	# Ensure Vardir for .25.4 -> .25.5 clients
	file { "/var/lib/": ensure => directory,}

	# Package Calls
	package{"$facter": 
		source => "$pkg_base/$facter",
		}
	package{"$firstclass": source => "$pkg_base/$firstclass",}
	#package{"$flash": source => "$pkg_base/$flash",}
	package{"$sophos": source => "$pkg_base/$sophos",}
	package{"$dnealian": source => "$pkg_base/$dnealian",}
	package{"$textwrangler": 
		source => "$pkg_base/$textwrangler",
		provider => appdmg,
		}
	package{"$ard": source => "$pkg_base/$ard",}
	package{"$firefox": 
		source => "$pkg_base/$firefox",
		provider => appdmg,
		}

	 # case $puppetversion{
	 # 		 "0.25.4": {
	 # 				file { "/var/lib/puppet":
	 # 					ensure => directory,
	 # 					before => Exec["Move_puppet_vardir"],
	 # 				}
	 # 				
	 # 				exec { "Move_puppet_vardir":
	 # 					command => "cp -R /var/puppet /var/lib/puppet",
	 # 					path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
	 # 					require => File["/var/lib/puppet"],
	 # 					onlyif => "ls /var/lib/puppet",
	 # 				}
	 # 				
	 # 				package{"$puppetcurrent":
	 # 					source => "$pkg_base/$facter",
	 # 					require => Exec["Move_puppet_vardir"],
	 # 					}
	 # 				
	 # 			}
	 # 		}
	
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

} # End of Class
