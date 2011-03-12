define mcollective_module::plugin ( $source , $type="plugin" , $repo="puppetlabs" ) {

   include mcollective_module::params

   $localpath = $type ? {
       client  => "/usr/local/bin/${name}",
       default => "${mcollective_module::params::libdir}/mcollective/${name}",
   }

   file { "${localpath}":
        owner   => root,
        group   => root,
        mode    => $type ? {
            client  => "0555",
            default => "0444",
        },
        require => Package["mcollective"],
        notify  => Service["mcollective"],
        source  => "${mcollective_module::params::general_base_source}/mcollective_module/mcollective-plugins/$repo/${source}",
   }

}