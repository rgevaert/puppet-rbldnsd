class rbldnsd::install {

  package {
    $rbldnsd::package:
      ensure => $rbldnsd::ensure;
  }

}
