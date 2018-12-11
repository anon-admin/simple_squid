class squid::user::definition ($squid_user = $squid::squid_user, $squid_id = $squid::squid_id, $srv_name = $squid::srv_name ) inherits squid {
  exec { [
    "/usr/local/bin/gidmod.sh ${squid_id} ${squid_user}",
    "/usr/local/bin/uidmod.sh ${squid_id} ${squid_user}"]: require => Mount["/usr/local/bin"], }

  class { 'squid::user::group':
    squid_user => $squid_user,
    squid_id   => $squid_id
  }

  user { "${squid_user}":
    ensure  => present,
    uid     => "${squid_id}",
    gid     => "${squid_user}",
    require => [Exec["/usr/local/bin/uidmod.sh ${squid_id} ${squid_user}"], Group["${squid_user}"]],
    before  => [Package[squid3], Service["${srv_name}"]],
  }

}
