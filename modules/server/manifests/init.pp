class server {
	
	mcollective_module::plugin { "agent/yaml_store.rb": source => "agent/yaml_store.rb" , repo => "huron" }
	
}