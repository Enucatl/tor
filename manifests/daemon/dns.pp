# DNS definition
define tor::daemon::dns(
  $port             = 0,
  $listen_addresses = [] ) {

  concat::fragment { "08.dns.${name}":
    content => template('tor/torrc.dns.erb'),
    order   => '08',
    target  => $tor::daemon::config_file,
  }
}

