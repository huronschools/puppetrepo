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

