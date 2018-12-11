class squid::monit inherits monit::minimal::config {

  include squid
  $srv_name = $squid::srv_name

  monit::fullfill_service{ "${srv_name}":
    module => "squid",
  }
}