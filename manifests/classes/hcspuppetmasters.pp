class hcspuppetmasters {

	include passenger
	include puppetusers
	
	file {"/usr/bin/rubyexternalnode.pp":
		source => "puppet:///files/rubyexternalnode.rb",
		mode => 0755,
		owner => root,
		group => wheel,
	}
	
	file {"/Library/WebServer/CGI-Executables/pclean.rb":
	source => "puppet:///files/pclean.rb",
	mode => 0755,
	owner => root,
	group => staff,
	}

}