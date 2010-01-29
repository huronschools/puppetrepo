#/etc/puppet/manifests/classes/app_deploy_wes.pp
#
# Module to deploy Mac Packages
# Convenience component for installing pkg.dmg packages.

define app_deploy_wes($sourcedir = false)
{
  $sourcedir_real = $sourcedir ? {
    false => "http://wesreplica.huronhs.com/pkgs",
    default => $sourcedir
  }
  package { $name:
    ensure => installed,
    provider => appdmg,
    source => "$sourcedir_real/$name"
  }
}

