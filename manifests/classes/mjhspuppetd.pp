# /etc/puppet/manifests/classes/mjhspuppetd.pp

class mjhs_puppetd {

	file { "/usr/bin/puppetd.sh":
		owner => "root",
		group => "wheel",
		mode => 755,
		source => "puppet:///files/mjhspuppetd.sh",
	}
	file { "/usr/bin/puppetd.rb":
		owner => root,
		group => wheel,
		mode => 755,
		source => "puppet:///files/puppetd.rb",
	}
}
