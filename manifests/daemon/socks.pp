# @summary Extend basic Tor configuration with a snippet based configuration.
#          Torsocks module.
#
# @example Example Torsocks configuration
#   tor::daemon::socks { "listen_locally":
#     port     => 0,
#     policies => 'your super policy';
#   }
#
# @param ensure
#   Whether this module should be used or not.
#
# @param port
#   The SocksPort.
#
# @param policies
#   Set policies to limit who can connect to the SocksPort.
#
define tor::daemon::socks(
  Enum['present', 'absent'] $ensure = 'present',
  Tor::Port $port                   = undef,
  Optional[Array[String]] $policies = undef,
) {
  if $ensure == 'present' {
    concat::fragment { '02.socks':
      content => epp('tor/torrc/02_socks.epp', {
        'port'     => $port,
        'policies' => $policies,
      }),
      order   => '02',
      target  => $tor::config_file,
    }
  }
}
