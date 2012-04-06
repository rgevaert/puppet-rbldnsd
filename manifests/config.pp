class rbldnsd::config {

  file {
    '/etc/default/rbldnsd':
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => '0644',
      content => template('rbldnsd/default.erb');

    $rbldnsd::root:
      ensure  => directory,
      mode    => '0755',
      owner   => root,
      group   => root;

    'rbldnsd_workingdir':
      ensure  => directory,
      name    => "${rbldnsd::root}/${rbldnsd::workingdir}",
      mode    => '0755',
      owner   => rbldns,
      group   => root,
  }

}
