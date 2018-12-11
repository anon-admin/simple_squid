class squid::no( $srv_name = $squid::srv_name ) inherits squid {
  Package["squid3"] {
    ensure => purged,
  }
  
  File["/etc/${srv_name}/squid.conf"] {
    ensure => absent,
  }
  
  File["/etc/default/${srv_name}"] {
    ensure => absent,
  }

  File ["/etc/${srv_name}","/var/log/${srv_name}","/var/spool/${srv_name}"] {
    ensure => absent,
    recurse => true,
  }
  
  Service["${srv_name}"] {
    enable => false,
    ensure => stopped,
  }
}
