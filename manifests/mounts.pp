class squid::mounts (
  $squid_user   = $squid::squid_user,
  $squid_lvname = $squid::squid_lvname,
  $squid_vgname = $squid::squid_vgname,
  $squid_lvfs   = $squid::squid_lvfs,
  $squid_mountpoint = $squid::squid_mountpoint,
  $srv_name = $squid::srv_name) inherits squid {
  file { "${squid_mountpoint}": ensure => directory, }

  include squid::create_lvm 

  mount { "${squid_mountpoint}":
    device  => "LABEL=${squid_vgname}-${squid_lvname}",
    fstype  => "${squid_lvfs}",
    options => "defaults",
    pass    => 2,
    atboot  => true,
    ensure  => mounted,
    require => File["${squid_mountpoint}"],
  }

  mount { "/etc/${srv_name}":
    device  => "${squid_mountpoint}/etc",
    require => [File["/etc/${srv_name}"], Mount["${squid_mountpoint}"]],
  }

  mount { "/var/log/${srv_name}":
    device  => "${squid_mountpoint}/log",
    require => [File["/var/log/${srv_name}"], Mount["${squid_mountpoint}"]],
  }

  mount { "/var/spool/${srv_name}":
    device  => "${squid_mountpoint}/cache",
    require => [File["/var/spool/${srv_name}"], Mount["${squid_mountpoint}"]],
  }

  Mount[
    "/etc/${srv_name}", "/var/log/${srv_name}", "/var/spool/${srv_name}"] {
    fstype  => none,
    options => "bind,rw",
    before  => Package[squid3],
    atboot  => true,
    ensure  => mounted,
    notify  => Service["${srv_name}"],
  }

  contain squid::clean
}
