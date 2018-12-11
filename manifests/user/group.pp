class squid::user::group ($squid_user, $squid_id, $proxy_group = $userids::conf::proxygroup::proxy_group) inherits 
userids::conf::proxygroup {
  contain squid

  if $squid_user == $proxy_group {
    Group["${squid_user}"] {
      ensure  => present,
      require => Exec["/usr/local/bin/gidmod.sh ${squid_id} ${squid_user}"],
      before  => Package[squid3],
    }
  } else {
    group { "${squid_user}":
      ensure  => present,
      gid     => "${squid_id}",
      require => Exec["/usr/local/bin/gidmod.sh ${squid_id} ${squid_user}"],
      before  => Package[squid3],
    }
  }

}