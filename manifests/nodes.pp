# /etc/puppet/manifests/nodes.pp

node "demomini.huronhs.com" {
	include nrpe
	include server_puppet_conf
}
node "wesdocs.huronhs.com" {
	include nrpe
	include server_puppet_conf
}
node "testing-client.huronhs.com"{
	include server_puppet_conf
	include mc_serverplugins
	include mcollective_module
}
node "odm.testhuronenvironment.com"{
	include mcollective_module
	include general_image
}
node "msreplica-client.huronhs.com" {
	include server_puppet_conf
	include nrpe
	include mcollective_module
	include mc_serverplugins
}
node "helpdesk-client.huronhs.com" {
	include server_puppet_conf
	include mcollective_module
	include mc_serverplugins
	include nrpe
}
node "wesreplica-client.huronhs.com" {
	include server_puppet_conf
	include mcollective_module
	include mc_serverplugins
	include nrpe
}
node "boe.huronhs.com" {
	include general_image
	include garyclass
	include boe
}
node "ldap.huronhs.com" {
	include mcollective_module
	include general
}
node "logstash.huronhs.com" {
	include mcollective_module
	include activemq
	include general
}
#Gary's Laptop
node "ym8243s5ze3.huronhs.com" {
	include general_image
	include mcollective_module
	include garyclass
	include boe
}
node "kstest.huronhs.com"{
	include general
	include mcollective_module
	include desktop
}

#kstest node
node "clzf581.huronhs.com"{
	include general
	include mcollective_module
	include desktop
}

node default {
	include general
}
