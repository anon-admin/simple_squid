class squid::monit inherits monit::minimal::config {
  monit::fullfill_service { "squid3": module => "squid", }

}