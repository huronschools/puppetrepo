# /etc/puppet/manifests/classes/puppetlaunchdaemon.pp

class puppet_LaunchDaemon {

	case $macosx_productversion_major {
		10.4: { 
			file { "/Library/LaunchDaemons/com.huronhs.puppetconfig.plist":
				owner => root,
				group => wheel,
				mode => 644,
				source => "puppet:///files/com.huronhs.puppetconfig.plist",
				ensure => present,
			} # End of File

			service { "com.huronhs.puppetconfig":
				enable => true,
				ensure => running,
				subscribe => File["/Library/LaunchDaemons/com.huronhs.puppetconfig.plist"],
				require => File["/Library/LaunchDaemons/com.huronhs.puppetconfig.plist"],
			}# End of Service
		       }
		10.5: { 
			file { "/Library/LaunchDaemons/com.huronhs.puppetconfig.plist":
				owner => root,
				group => wheel,
				mode => 644,
				source => "puppet:///files/com.huronhs.puppetconfig.plist",
				ensure => present,
			} # End of File

			service { "com.huronhs.puppetconfig":
				enable => true,
				ensure => running,
				subscribe => File["/Library/LaunchDaemons/com.huronhs.puppetconfig.plist"],
				require => File["/Library/LaunchDaemons/com.huronhs.puppetconfig.plist"],
			}# End of Service
		       }			
		10.6: { 
			file { "/Library/LaunchDaemons/com.huronhs.puppetconfig.plist":
				owner => root,
				group => wheel,
				mode => 644,
				source => "puppet:///files/com.huronhs.puppetconfig.plist",
				ensure => present,
			} # End of File

			service { "com.huronhs.puppetconfig":
				enable => true,
				ensure => running,
				subscribe => File["/Library/LaunchDaemons/com.huronhs.puppetconfig.plist"],
				require => File["/Library/LaunchDaemons/com.huronhs.puppetconfig.plist"],
			}# End of Service
	           }
	}
	

} #End of Class
