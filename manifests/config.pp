# Class rbldnsd::config
# =====================
#
#
class rbldnsd::config (
  $ip         = $::rbldnsd::ip,
  $root       = $::rbldnsd::root,
  $workingdir = $::rbldnsd::workingdir,
  $stats      = $::rbldnsd::stats,
  $acl        = $::rbldnsd::acl,
  $zones      = $::rbldnsd::zones,
){

  file {
    '/etc/default/rbldnsd':
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => '0644',
      content => template('rbldnsd/default.erb');

    $root:
      ensure => directory,
      mode   => '0755',
      owner  => root,
      group  => root;

    "${root}/${workingdir}":
      ensure => directory,
      mode   => '0755',
      owner  => rbldns,
      group  => root,
  }

}
