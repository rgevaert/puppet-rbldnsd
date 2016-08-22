# Class: rbldnsd
#
# This module manages rbldnsd
#
# This was forked from Matt Taggart <taggart@riseup.net>
# https://labs.riseup.net/code/projects/module-rbldnsd/
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class rbldnsd (
    $zones,
    $ip             = $rbldnsd::params::ip,
    $root           = $rbldnsd::params::root,
    $workingdir     = $rbldnsd::params::workingdir,
    $log            = $rbldnsd::params::log,
    $stats          = $rbldnsd::params::stats,
    $acl            = $rbldnsd::params::acl,

    $ensure         = $rbldnsd::params::ensure,
    $package        = $rbldnsd::params::package,
    $servicename    = $rbldnsd::params::servicename,
    $service_ensure = $rbldnsd::params::service_ensure,
  ) inherits ::rbldnsd::params {

    class{'::rbldnsd::install':;} ~>
    class{'::rbldnsd::config':;} ~>
    class{'::rbldnsd::service':;}
}
