class squid::config( $srv_name = $squid::srv_name ) inherits squid {
  
  include storage
  if $storage::squid {
    contain squid::mounts
  }
  contain squid::user::definition

  File[
    "/etc/${srv_name}", "/var/log/${srv_name}", "/var/spool/${srv_name}"] {
    ensure => directory,
    group  => "${squid_user}",
    mode   => "g+w",
  }

  File[
    "/etc/${srv_name}", "/var/spool/${srv_name}"] {
    require => Group["${squid_user}"],
  }

  File["/var/log/${srv_name}"] {
    require => [Group["${squid_user}"], Mount["/var/log"]], }

  Package["squid3"] {
    ensure => latest,
    require => File["/etc/apt/sources.list"], 
  }
    
  File["/etc/${srv_name}/squid.conf"] {
    notify => Service["${srv_name}"],
    #content => template("squid/squid.conf.erb"),
  }
  

  File["/etc/default/${srv_name}"] {
    ensure => file,
    source => "puppet:///modules/squid/squid3-default",
  }

# anonymizer
#     file { "/etc/${srv_name}/squid.conf":
#         content => template("common/squid.conf.erb"),
#   require => [ Package[squid3], Service["privoxy"], Mount["/etc/${srv_name}"] ],
#   notify  => Service["${srv_name}"],
#     }

  
}