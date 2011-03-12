class mcollective_module::params {

	# Class: mcollective_module::params
	#
	# Sets internal variables and defaults for mcollective module
	# This class is automatically loaded in all the classes that use the values set here 
	#

	## DEFAULTS FOR VARIABLES USERS CAN SET
	# (Here are set the defaults, provide your custom variables externally)
	# (The default used is in the line with '')

	    $client = $mcollective_client ? {
	        ''      => "yes",
	        default => "${mcollective_client}",
	    }

	    $server = $mcollective_server ? {
	        ''      => "yes",
	        default => "${mcollective_server}",
	    }

	    $plugins = $mcollective_plugins ? {
	        ''      => "yes",
	        default => "${mcollective_plugins}",
	    }



	# Pre Shared Key (SET a Different ONE!)
	    $psk = $mcollective_psk ? {
	        ''      => "buckeyes",
	        default => "${mcollective_psk}",
	    }

	# Stomp settings
	    $stomp_host = $mcollective_stomp_host ? {
	        ''      => "ldap.huronhs.com",
	        default => "${mcollective_stomp_host}",
	    }

	    $stomp_port = $mcollective_stomp_port ? {
	        ''      => "6163",
	        default => "${mcollective_stomp_port}",
	    }

	    $stomp_user = $mcollective_stomp_user ? {
	        ''      => "mcollective",
	        default => "${mcollective_stomp_user}",
	    }

	    $stomp_password = $mcollective_stomp_password ? {
	        ''      => "marionette",
	        default => "${mcollective_stomp_password}",
	    }

	# Internal vars
	    $factsource = $mcollective_factsource ? {
	        ''      => "yaml",
	        default => "${mcollective_factsource}",
	    }

	# Variables defined also in other Example42 modules
	# Here are re-set in order to permit usage of only this mcollective module

	    $puppet_classesfile = "/var/lib/puppet/state/classes.txt"

	    $service_hasstatus = $operatingsystem ? {
	        debian  => "false",
	        ubuntu  => "false",
	        default => "true",
	    }



	## EXTRA INTERNAL VARIABLES

	    $packagename_client = $operatingsystem ? {
	        default => "mcollective-client",
	    }

		$packagename_stomp = $operatingsystem ? {
	        debian  => "libstomp-ruby",
	        ubuntu  => "libstomp-ruby",
	        default => "rubygem-stomp",
	    }
	
	    $configfile_client = $operatingsystem ? {
	        default => "/etc/mcollective/client.cfg",
	    }

	    # Libdir. Used in config templates
	    $libdir = $operatingsystem ? {
	        darwin => "/usr/libexec/mcollective",
	        centos => "/usr/libexec/mcollective",
	    }
	
	  	$logdir = $operatingsystem ? {
			default => "/var/log/mcollective",
	}



	## MODULE INTERNAL VARIABLES
	# (Modify to adapt to unsupported OSes)

	    $packagename = $operatingsystem ? {
	        darwin => "MCollective_Installer_Full-1.1.1Revb.dmg",
			default => "mcollective",
	    }

	    $servicename = $operatingsystem ? {
	        darwin => "com.huronhs.mcollective",
			default => "mcollective",
	    }
		
	    $processname = $operatingsystem ? {
	        default => "mcollectived",
	    }

	    $hasstatus = $operatingsystem ? {
	        default => true,
	    }

	    $configfile = $operatingsystem ? {
	        default => "/etc/mcollective/server.cfg",
	    }

	    $configfile_mode = $operatingsystem ? {
	        default => "640",
	    }

	    $configfile_owner = $operatingsystem ? {
	        default => "root",
	    }

	    $configfile_group = $operatingsystem ? {
	        darwin => "wheel",
			default => "root",
	    }

	    $configdir = $operatingsystem ? {
	        default => "/etc/mcollective",
	    }
	
	    $initconfigfile = $operatingsystem ? {
	        debian  => "/etc/default/mcollective",
	        ubuntu  => "/etc/default/mcollective",
	        default => "/etc/sysconfig/mcollective",
	    }



	## FILE SERVING SOURCE
	# Sets the correct source for static files
	# In order to provide files from different sources without modifying the module
	# you can override the default source path setting the variable $base_source
	# Ex: $base_source="puppet://ip.of.fileserver" or $base_source="puppet://$servername/myprojectmodule"
	# What follows automatically manages the new source standard (with /modules/) from 0.25 

	    case $base_source {
	        '': {
	            $general_base_source = $puppetversion ? {
	                /(^0.25)/ => "puppet:///modules",
	                /(^0.)/   => "puppet://$servername",
	                default   => "puppet:///modules",
	            }
	        }
	        default: { $general_base_source=$base_source }
	    }

	}
