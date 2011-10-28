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
	mcollective_module::plugin { "agent/etc_facts.rb": source => "agent/etc_facts.rb" , repo => "huron" }
	mcollective_module::plugin { "agent/etc_facts.ddl": source => "agent/etc_facts.ddl" , type => "ddl" , repo => "huron" }
	mcollective_module::plugin { "agent/printer.rb": source => "agent/printer.rb", repo => 'huron' }
	mcollective_module::plugin { 'agent/printer.ddl': source => 'agent/printer.ddl', type => 'ddl', repo => 'huron' }

#### puppetlabs repo
    # Filemgr plugin
    mcollective_module::plugin { "agent/filemgr.rb": source => "agent/filemgr/agent/filemgr.rb", repo => 'mcollective-plugins' } 

    # Iptables plugin
    mcollective_module::plugin { "agent/iptables.rb": source => "agent/iptables-junkfilter/agent/iptables.rb", repo => 'mcollective-plugins'}
    mcollective_module::plugin { "agent/iptables.ddl": source => "agent/iptables-junkfilter/agent/iptables.ddl" , type => "ddl", repo => 'mcollective-plugins' }
    if ( $mcollective_client == "yes" ) {
        mcollective_module::plugin { "application/iptables.rb": source => "agent/iptables-junkfilter/application/iptables.rb", repo => 'mcollective-plugins' }
    }

    # package Plugin
    mcollective_module::plugin { "agent/package.rb": source => "agent/package/agent/puppet-package.rb", repo => 'mcollective-plugins' }
    mcollective_module::plugin { "agent/package.ddl": source => "agent/package/agent/package.ddl" , type => "ddl", repo => 'mcollective-plugins' }
    if ( $mcollective_client == "yes" ) {
        mcollective_module::plugin { "application/package.rb": source => "agent/package/application/package.rb", repo => 'mcollective-plugins' }
    }


    # puppetral plugin
    mcollective_module::plugin { "agent/puppetral.rb": source => "agent/puppetral/agent/puppetral.rb", repo => 'mcollective-plugins' }
    mcollective_module::plugin { 'agent/puppetral.ddl': source => 'agent/puppetral/agent/puppetral.ddl', repo => 'mcollective-plugins' }

    # puppetd plugin
    mcollective_module::plugin { "agent/puppetd.rb": source => "agent/puppetd/agent/puppetd.rb", repo => 'mcollective-plugins' }
    mcollective_module::plugin { "agent/puppetd.ddl": source => "agent/puppetd/agent/puppetd.ddl" , type => "ddl", repo => 'mcollective-plugins' }
    if ( $mcollective_client == "yes" ) {
        mcollective_module::plugin { "application/puppetd.rb": source => "agent/puppetd/application/puppetd.rb", repo => 'mcollective-plugins' }
    }

    # service plugin
    mcollective_module::plugin { "agent/service.rb": source => "agent/service/agent/puppet-service.rb", repo => 'mcollective-plugins' }
    mcollective_module::plugin { "agent/service.ddl": source => "agent/service/agent/service.ddl" , type => "ddl", repo => 'mcollective-plugins' }
    if ( $mcollective_client == "yes" ) {
        mcollective_module::plugin { "application/service.rb": source => "agent/service/application/service.rb", repo => 'mcollective-plugins' }
    }

    # facts
    mcollective_module::plugin { "facts/facter.rb": source => "facts/facter/facter.rb", repo => 'mcollective-plugins' }
    mcollective_module::plugin { "facts/facter_facts.rb": source => "facts/facter/facter_facts.rb", repo => 'mcollective-plugins' }




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
    mcollective_module::plugin { "agent/process.rb": source => "agent/process/agent/process.rb" , repo => "mcollective-plugins" }
    if ( $mcollective_client == "yes" ) {
        mcollective_module::plugin { "mc-pgrep": source => "agent/process/sbin/mc-pgrep" , type => "client" , repo => "mcollective-plugins" }
    }

    # puppetca plugin
    mcollective_module::plugin { "agent/puppetca.rb": source => "agent/puppetca/agent/puppetca.rb" , repo => "mcollective-plugins" }
    mcollective_module::plugin { "agent/puppetca.ddl": source => "agent/puppetca/agent/puppetca.ddl" , type => "ddl" , repo => "mcollective-plugins" }

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
    mcollective_module::plugin { "agent/nrpe.rb": source => "agent/nrpe/nrpe.rb" , repo => "example42" }
    mcollective_module::plugin { "agent/nrpe.ddl": source => "agent/nrpe/nrpe.ddl" , type => "ddl" , repo => "example42" }
    if ( $mcollective_client == "yes" ) {
        mcollective_module::plugin { "mc-nrpe": source => "agent/nrpe/mc-nrpe" , type => "client" , repo => "example42" }
    }
    
}
