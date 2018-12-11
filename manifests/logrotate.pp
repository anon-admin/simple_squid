class squid::logrotate {

  include squid
  $srv_name = $squid::srv_name

  rsyslog::fullfill_service{ "${srv_name}": module => "squid", }
}