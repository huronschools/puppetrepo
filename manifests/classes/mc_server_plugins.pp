# /etc/puppet/manifests/classes/mc_server_plugins.pp

class mc_serverplugins {

	file { "/usr/libexec/mcollective/mcollective/agent/yaml_store.rb":
		ensure 		=> file,
		owner		=> "root",
		group  		=> "wheel",
		mode		=> 0755,	
		source		=> "puppet:///files/mc_plugins/yaml_store.rb",
	}
	
}
