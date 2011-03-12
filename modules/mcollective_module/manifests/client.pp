#
# Class: mcollective_module::client
#
# Manages mcollective client
# Include it to install mcollective client
#
# Usage:
# Set $mcollective_client=yes and include mcollective to autoload mcollective_module::client
#
class mcollective_module::client {

    # Load the variables used in this module. Check the params.pp file 
    require mcollective_module::params

    # Basic Package - Configuration file management
    package { "mcollective_client":
        name     => "${mcollective_module::params::packagename_client}",
        ensure   => present,
    }

    file { "mcollective_client.conf":
        path    => "${mcollective_module::params::configfile_client}",
        mode    => "${mcollective_module::params::configfile_mode}",
        owner   => "${mcollective_module::params::configfile_owner}",
        group   => "${mcollective_module::params::configfile_group}",
        ensure  => present,
        require => Package["mcollective_client"],
        content => template("mcollective_module/client.cfg.erb"),
    }

    # Include Plugins
    if ( $mcollective_module::params::plugins != "no") { include mcollective_module::plugins }
}
