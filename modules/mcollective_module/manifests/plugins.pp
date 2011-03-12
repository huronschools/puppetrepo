# class mcollective_module::plugins
# 
# This class selects and installs mcollective-plugins from various sources 
#
# The sources are based on
# puppetlabs repo : http://github.com/puppetlabs/mcollective-plugins.git
# ripienaar repo : http://github.com/ripienaar/mcollective-plugins.git
# example42 repo : http://github.com/example42/mcollective-plugins-puppi.git
# 
# Usage:
# include mcollective_module::plugins
#
class mcollective_module::plugins {


#### huron repo
	mcollective_module::plugin { "agent/yaml_store.ddl": source => "agent/yaml_store.ddl" , type => "ddl" , repo => "huron" }

#### puppetlabs repo
    # Filemgr plugin
    mcollective_module::plugin { "agent/filemgr.rb": source => "agent/filemgr/filemgr.rb" } 

    # Iptables plugin
    mcollective_module::plugin { "agent/iptables.rb": source => "agent/iptables-junkfilter/iptables.rb" }
    mcollective_module::plugin { "agent/iptables.ddl": source => "agent/iptables-junkfilter/iptables.ddl" , type => "ddl" }
    if ( $mcollective_client == "yes" ) {
        mcollective_module::plugin { "mc-iptables": source => "agent/iptables-junkfilter/mc-iptables" , type => "client" }
    }

    # package Plugin
    mcollective_module::plugin { "agent/package.rb": source => "agent/package/puppet-package.rb" }
    mcollective_module::plugin { "agent/package.ddl": source => "agent/package/package.ddl" , type => "ddl" }
    if ( $mcollective_client == "yes" ) {
        mcollective_module::plugin { "mc-package": source => "agent/package/mc-package" , type => "client" }
    }


    # puppetd plugin
    mcollective_module::plugin { "agent/puppetd.rb": source => "agent/puppetd/puppetd.rb" }
    mcollective_module::plugin { "agent/puppetd.ddl": source => "agent/puppetd/puppetd.ddl" , type => "ddl" }
    if ( $mcollective_client == "yes" ) {
        mcollective_module::plugin { "mc-puppetd": source => "agent/puppetd/mc-puppetd" , type => "client" }
    }

    # service plugin
    mcollective_module::plugin { "agent/service.rb": source => "agent/service/puppet-service.rb" }
    mcollective_module::plugin { "agent/service.ddl": source => "agent/service/service.ddl" , type => "ddl" }
    if ( $mcollective_client == "yes" ) {
        mcollective_module::plugin { "mc-service": source => "agent/service/mc-service" , type => "client" }
    }

    # facts
    mcollective_module::plugin { "facts/facter.rb": source => "facts/facter/facter.rb" }




#### ripienaar repo
    # Nagger notify plugin
    # mcollective_module::plugin { "agent/naggernotify.rb": source => "agent/naggernotify/naggernotify.rb" , repo => "ripienaar" }
    # mcollective_module::plugin { "agent/naggernotify.ddl": source => "agent/naggernotify/naggernotify.ddl" , type => "ddl" , repo => "ripienaar" }

    # Net test plugin - See README in files directory
    mcollective_module::plugin { "agent/nettest.rb": source => "agent/nettest/nettest.rb"  , repo => "ripienaar"}
    mcollective_module::plugin { "agent/nettest.ddl": source => "agent/nettest/nettest.ddl" , type => "ddl" , repo => "ripienaar" }

	# Meta Registration Plugin
	mcollective_module::plugin { "registration/meta.rb": source => "registration/meta.rb"  , repo => "ripienaar"}

    # nrpe plugin
    # mcollective_module::plugin { "agent/nrpe.rb": source => "agent/nrpe/nrpe.rb" , repo => "ripienaar" }
    # mcollective_module::plugin { "agent/nrpe.ddl": source => "agent/nrpe/nrpe.ddl" , type => "ddl" , repo => "ripienaar" }
    # if ( $mcollective_client == "yes" ) {
    #     mcollective_module::plugin { "mc-nrpe": source => "agent/nrpe/mc-nrpe" , type => "client" , repo => "ripienaar" }
    # }

    # process plugin
    mcollective_module::plugin { "agent/process.rb": source => "agent/process/process.rb" , repo => "ripienaar" }
    if ( $mcollective_client == "yes" ) {
        mcollective_module::plugin { "mc-pgrep": source => "agent/process/mc-pgrep" , type => "client" , repo => "ripienaar" }
    }

    # puppetca plugin
    mcollective_module::plugin { "agent/puppetca.rb": source => "agent/puppetca/puppetca.rb" , repo => "ripienaar" }
    mcollective_module::plugin { "agent/puppetca.ddl": source => "agent/puppetca/puppetca.ddl" , type => "ddl" , repo => "ripienaar" }

    # urltest plugin
    mcollective_module::plugin { "agent/urltest.rb": source => "agent/urltest/urltest.rb" , repo => "ripienaar" }
    mcollective_module::plugin { "agent/urltest.ddl": source => "agent/urltest/urltest.ddl" , type => "ddl" , repo => "ripienaar" }
    if ( $mcollective_client == "yes" ) {
        mcollective_module::plugin { "mc-urltest": source => "agent/urltest/mc-urltest" , type => "client" , repo => "ripienaar" }
    }

    # vcsmgr plugin
    mcollective_module::plugin { "agent/vcsmgr.rb": source => "agent/vcsmgr/vcsmgr.rb" , repo => "ripienaar" }
    mcollective_module::plugin { "agent/vcsmgr.ddl": source => "agent/vcsmgr/vcsmgr.ddl" , type => "ddl" , repo => "ripienaar" }


#### Example42 Experiments 
    mcollective_module::plugin { "agent/puppi.rb": source => "agent/puppi/puppi.rb" , repo => "example42" }
    mcollective_module::plugin { "agent/puppi.ddl": source => "agent/puppi/puppi.ddl" , type => "ddl" , repo => "example42" }
    if ( $mcollective_client == "yes" ) {
        mcollective_module::plugin { "mc-puppi": source => "agent/puppi/mc-puppi" , type => "client" , repo => "example42" }
    }

    mcollective_module::plugin { "agent/nrpe.rb": source => "agent/nrpe/nrpe.rb" , repo => "example42" }
    mcollective_module::plugin { "agent/nrpe.ddl": source => "agent/nrpe/nrpe.ddl" , type => "ddl" , repo => "example42" }
    if ( $mcollective_client == "yes" ) {
        mcollective_module::plugin { "mc-nrpe": source => "agent/nrpe/mc-nrpe" , type => "client" , repo => "example42" }
    }
    
}
