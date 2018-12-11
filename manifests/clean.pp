class squid::clean($srv_name = $squid::srv_name) inherits squid {

  tidy { [ "/usr/tidy/var/squid",
           "/usr/tidy/etc/${srv_name}",
     "/usr/tidy/var/log/${srv_name}",
     "/usr/tidy/var/spool/${srv_name}" ]:
      recurse => true,
      backup  => false,
      age     => "4w",
      require => Mount["/usr/tidy"],
  }

  Mount["/etc/${srv_name}"] -> Tidy["/usr/tidy/etc/${srv_name}"]
  Mount["/var/log/${srv_name}"] -> Tidy["/usr/tidy/var/log/${srv_name}"]
  Mount["/var/spool/${srv_name}"] -> Tidy["/usr/tidy/var/spool/${srv_name}"]
}
