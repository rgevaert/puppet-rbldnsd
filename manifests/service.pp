# Class rbldnsd::service
# ======================
#
#
class rbldnsd::service {

  service {
    $rbldnsd::servicename:
      ensure     => $rbldnsd::service_ensure,
      hasrestart => true,
      hasstatus  => false,
      pattern    => 'rbldnsd';
  }
}
