# /etc/puppet/modules/desktop/centos.pp

class desktop::centos {
	
	service { "networkmanager":
        name       	=> "NetworkManager",
        ensure     	=> running,
        enable     	=> true,
        hasrestart 	=> true,
        hasstatus  	=> "true",
        pattern    	=> "NetworkManager",
        require  	=> [File["/lib/firmware/ipw2200-ibss.fw"], File["/lib/firmware/ipw2200-bss.fw"], File["/lib/firmware/ipw2200-sniffer.fw"]],
    }
	
	exec { "ModprobeFlip":
		command 	=> "/sbin/modprobe -r ipw2200; /sbin/modprobe ipw2200",
		path 		=> "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
		refreshonly => true,
	}

	file { "/lib/firmware/ipw2200-bss.fw":
		owner		=> "root",
		group 		=> "root",
		mode 		=> 755,
		source 		=> "puppet:///general/ipw2200-bss.fw",
		notify		=> Exec["ModprobeFlip"],
	}
	
	file { "/lib/firmware/ipw2200-ibss.fw":
		owner		=> "root",
		group 		=> "root",
		mode 		=> 755,
		source 		=> "puppet:///general/ipw2200-ibss.fw",
		notify		=> Exec["ModprobeFlip"],
	}
	
	file { "/lib/firmware/ipw2200-sniffer.fw":
		owner		=> "root",
		group 		=> "root",
		mode 		=> 755,
		source 		=> "puppet:///general/ipw2200-sniffer.fw",
		notify		=> Exec["ModprobeFlip"],
	}
	
	file { "/etc/sudoers":
		owner 		=> "root",
		group 		=> "root",
		mode		=> 440,
		source 		=> "puppet:///desktop/sudoers",
	}
	
}