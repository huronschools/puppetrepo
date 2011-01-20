# /etc/puppet/modules/mcplugins/manifests/init.pp

class mcplugins {
	
	# Push out plugins to the mcollective $libdir
	file { "/usr/libexec/mcollective/agent": 
		recurse => true,
		source 	=> "puppet:///modules/mcplugins/agent",
		require => File['/Library/LaunchDaemons/com.huronhs.mcollective.plist'],
		notify	=> Service['com.huronhs.mcollective'],
		owner 	=> "root",
		mode	=> 0755,
	}
	
	# I prefer the binaries to be put in /usr/sbin
	file { "/usr/sbin": 
		recurse => true,
		source 	=> "puppet:///modules/mcplugins/binaries",
		require	=> File['/usr/libexec/mcollective/agent'],
	}
}