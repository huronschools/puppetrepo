#/etc/puppet/manifests/classes/app_deploy_hhs.pp
#
# Module to deploy Mac Packages
# Convenience component for installing pkg.dmg packages.

define app_deploy_hhs($sourcedir = false)
{
  $sourcedir_real = $sourcedir ? {
    false => "http://www.huronhs.com/pkgs",
    default => $sourcedir
  }
  package { $name:
    ensure => installed,
    provider => appdmg,
    source => "$sourcedir_real/$name"
  }
}

