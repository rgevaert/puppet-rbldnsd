# Class rbldnsd::params
# =====================
#
#
class rbldnsd::params {

  # the IP that rbldnsd binds to
  $ip = '127.0.0.1'

  # the chroot that rbldnsd operates in
  $root = '/var/lib/rbldns'

  # the directory under the root that rbldnsd does it's work in
  $workingdir = 'dnsbl'

  # where to store the log file, relative to root/workingdir, disabled
  $log = ''

  # where to store the stats file, relative to root/workingdir
  $stats = 'stats.log'

  # the access control list, default no acls
  $acl = ''

  $ensure         = 'present'
  $package        = 'rbldnsd'
  $servicename    = 'rbldnsd'
  $service_ensure = 'running'
  $zones          = ''
}
