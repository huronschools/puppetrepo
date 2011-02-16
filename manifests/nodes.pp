# /etc/puppet/manifests/nodes.pp

node "demomini.huronhs.com" {
	include nrpe
	include server_puppet_conf
}
node "wesdocs.huronhs.com" {
	include nrpe
	include server_puppet_conf
}
node "testing.huronhs.com"{
	include server_puppet_conf
}
node "msreplica.huronhs.com" {
	include hcspuppetmasters
	include server_puppet_conf
	include nagiosusers
}
node "helpdesk.huronhs.com" {
	include server_puppet_conf
	include nrpe
}
node "wesreplica.huronhs.com" {
	include server_puppet_conf
	include nrpe
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
