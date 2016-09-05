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
    String $zones,
    String $ip             = $rbldnsd::params::ip,
    String $root           = $rbldnsd::params::root,
    String $workingdir     = $rbldnsd::params::workingdir,
    String $log            = $rbldnsd::params::log,
    String $stats          = $rbldnsd::params::stats,
    String $acl            = $rbldnsd::params::acl,

    String $ensure         = $rbldnsd::params::ensure,
    String $package        = $rbldnsd::params::package,
    String $servicename    = $rbldnsd::params::servicename,
    String $service_ensure = $rbldnsd::params::service_ensure,
  ) inherits ::rbldnsd::params {

    class{'::rbldnsd::install':;} ~>
    class{'::rbldnsd::config':;} ~>
    class{'::rbldnsd::service':;}
}
