# /etc/puppet/manifests/nodes.pp

node "demomini.huronhs.com" {
	include nrpe
}
node "wesdocs.huronhs.com" {
	include nrpe
}
node default {
	include general_image
}
node "testing.huronhs.com"{
	include nagios_osx_commands
	include nagios_hosts
	include nagios_services
}
node "msreplica.huronhs.com" {
	include hcspuppetmasters
	include nagiosusers
}
