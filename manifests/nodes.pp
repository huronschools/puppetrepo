# /etc/puppet/manifests/nodes.pp

node "demomini.huronhs.com" {
	include nrpe
}
node "wesdocs.huronhs.com" {
	include nrpe
}
node "testing.huronhs.com"{
	include mcollective
	include server_puppet_conf
}
node "msreplica.huronhs.com" {
	include hcspuppetmasters
	include nagiosusers
}
node "boe.huronhs.com" {
	include general_image
	include garyclass
	include boe
}

#Gary's Laptop
node "ym8243s5ze3.huronhs.com" {
	include general_image
	include garyclass
	include boe
}

node default {
	include general_image
}
