# /etc/puppet/manifests/classes/boepuppetd.pp

class boe_puppetd {

	file { "/usr/bin/puppetd.rb":
		owner => root,
		group => wheel,
		mode => 755,
		source => "puppet:///files/puppetd.rb",
	}
}
