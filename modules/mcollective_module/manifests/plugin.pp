define mcollective_module::plugin ( $source , $type="plugin" , $repo="puppetlabs" ) {

   	include mcollective_module::params

   $localpath = $type ? {
       client  => "/usr/local/bin/${name}",
       default => "${mcollective_module::params::defaultpath}/$name",
   }

   file { "${localpath}":
        owner   => "${mcollective_module::params::configfile_owner}",
        group   => "${mcollective_module::params::configfile_group}",
        mode    => $type ? {
            client  => "0555",
            default => "0444",
        },
        require => Package["${mcollective_module::params::packagename}"],
        notify  => Service["${mcollective_module::params::servicename}"],
        source  => "${mcollective_module::params::general_base_source}/mcollective_module/mcollective-plugins/$repo/${source}",
   }

}