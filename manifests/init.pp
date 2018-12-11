# Class: squid
#
# This module manages squid
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class squid($squid_lvname, $squid_vgname, $squid_lvsize, $squid_lvfs, $squid_mountpoint) inherits squid::install {

  if "${::lsbdistid}" == "Ubuntu" and $::lsbdistrelease > 16 {
    $srv_name = "squid"
  } else {
    $srv_name = "squid3"
  }

  include userids
  $squid_user = $userids::squid_user
  $squid_id = $userids::squid_id

  # $squid_lvname = 'squid'
  # $squid_vgname = 'DATA'
  # $squid_lvsize = '8G'
  # $squid_lvfs = 'ext4'
  # $squid_mountpoint = "/var/squid"

  file { ["/etc/${srv_name}", "/var/log/${srv_name}", "/var/spool/${srv_name}"]: }

  file { "/etc/${srv_name}/squid.conf":
    owner => root,
    group => root,
    mode  => 444,
  }

  file { "/etc/default/${srv_name}": }

  service { "${srv_name}": }
}

