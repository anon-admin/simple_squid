class squid::serveur(
  $localn,
  $conf_source,
  $srv_name = $squid::srv_name
) inherits squid::config {
  
  # ex : apt_source_list/squid3.conf.erb
  File["/etc/${srv_name}/squid.conf"] {
    content => template("${conf_source}.erb"),
  }
  
  include conf::network::resolv
  include ntp

  File["/etc/resolv.conf"] -> Service["${srv_name}"]
  Service["ntp"] -> Service["${srv_name}"]

  contain squid::service
}