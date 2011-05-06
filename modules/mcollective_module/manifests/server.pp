#
# Class: mcollective_module::server
#
# Manages mcollective server (the agent running on each node to manage)
# It defines package, service, main configuration file.
#
# Usage:
# Automatically used when you include mcollective
#
class mcollective_module::server {

    # Load the variables used in this module. Check the params.pp file 
    require mcollective_module::params

    # Basic Package - Service - Configuration file management
    package { "mcollective":
        name     => "${mcollective_module::params::packagename}",
        ensure   => present,
        require  => Package["stomp"],
    }

    package { "stomp":
        name     => "${mcollective_module::params::packagename_stomp}",
        ensure   => present,
    }

    service { "mcollective":
        name       => "${mcollective_module::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${mcollective_module::params::hasstatus}",
        pattern    => "${mcollective_module::params::processname}",
        require    => Package["mcollective"],
        subscribe  => File["mcollective.conf"],
    }

    file { "mcollective.conf":
        path    => "${mcollective_module::params::configfile}",
        mode    => "${mcollective_module::params::configfile_mode}",
        owner   => "${mcollective_module::params::configfile_owner}",
        group   => "${mcollective_module::params::configfile_group}",
        ensure  => present,
        require => Package["mcollective"],
        notify  => Service["mcollective"],
        content => template("mcollective_module/server.cfg.erb"),
    }

	file { "/etc/mcollective/facts.yaml":
		ensure 		=> file,
		content		=> inline_template("<%= facts = {}; scope.to_hash.each_pair {|k,v| facts[k.to_s] = v.to_s}; facts.to_yaml %>"),
		before		=> Service["mcollective"],
		require		=> Package["mcollective"],
		notify		=> Service["mcollective"],
	}

    # Include Plugins
    include mcollective_module::plugins

}