class squid::service($squid_user = $squid::squid_user, $srv_name = $squid::srv_name) inherits squid {
  
  contain squid::config
  
  Service["${srv_name}"] {
    ensure  => running,
    enable  => true,
    require => [
      File["/etc/${srv_name}/squid.conf"],
      User["${squid_user}"]],
  }
  Package["squid3"] -> Service["${srv_name}"]

  include storage
  if $storage::squid {
    include squid::mounts
    Mount["/etc/${srv_name}", "/var/log/${srv_name}", "/var/spool/${srv_name}"] -> Service["${srv_name}"]
  }

  contain squid::monit
  Service["${srv_name}"] -> File["/etc/monit/conf.d/${srv_name}"]

  include squid::logrotate
}