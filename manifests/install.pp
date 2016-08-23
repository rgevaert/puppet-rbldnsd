# Class rbldnsd::install
# ======================
#
#
class rbldnsd::install {

  package {
    $rbldnsd::package:
      ensure => $rbldnsd::ensure;
  }

}
