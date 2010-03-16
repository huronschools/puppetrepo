# /etc/puppet/manifests/nodes.pp

node 'boe.huronhs.com' inherits basenode {
}

node "demomini.huronhs.com" {
	include nrpe
}
node "wesdocs.huronhs.com" {
	include nrpe
}
node default {
	include puppet_LaunchDaemon
}

