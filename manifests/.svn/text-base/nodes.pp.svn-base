# /etc/puppet/manifests/nodes.pp

node default {
	include puppet_LaunchDaemon
}
node "boe.huronhs.com" inherits basenode {
}
node 'localhost' inherits images_general{
}
node 'staff' inherits basenode {
}
node 'boe' inherits basenode {
}

