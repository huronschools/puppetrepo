# /etc/puppet/manifests/nodes.pp

node "demomini.huronhs.com" {
	include nrpe
}
node "wesdocs.huronhs.com" {
	include nrpe
}
node "testing.huronhs.com"{
	include mcollective
}
node "msreplica.huronhs.com" {
	include hcspuppetmasters
	include nagiosusers
}
node "boe.huronhs.com" {
	include general_image
	include boe
}
node default {
	include general_image
}
