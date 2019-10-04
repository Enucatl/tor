# @summary Main class, includes all other classes.
#
# @param arm
#   Install tor-arm.
#
# @param automap_hosts_on_resolve
#   Enables AutomapOnResolve.
#
# @param data_dir
#   Tor's main data directory.
#
# @param config_file
#   Tor's main config file (torrc).
#
# @param log_rules
#   Tor logging rules.
#
# @param safe_logging
#   Scrub potentially sensitive strings from log messages.
#
# @param torsocks
#   Install torsocks.
#
# @param version
#   The specific version of Tor that should be installed.
#
# @param use_bridges
#   Use Bridges as your entry node.
#
# @param use_upstream_repository
#   Install Tor and related packages from the upstream repository instead of
#   using your distribution's.
#
# @param upstream_release
#   What release from the upstream repository should be used to install Tor and
#   related packages.
#
class tor (
  Boolean $arm                      = false,
  Boolean $automap_hosts_on_resolve = false,
  Stdlib::Unixpath $data_dir        = '/var/lib/tor',
  String  $config_file              = '/etc/tor/torrc',
  Array   $log_rules                = [ 'notice file /var/log/tor/notices.log' ],
  Boolean $safe_logging             = true,
  Boolean $torsocks                 = false,
  String  $version                  = 'installed',
  Boolean $use_bridges              = false,
  Boolean $use_upstream_repository  = false,
  String  $upstream_release         = 'stable',
) {

  include ::tor::install
  include ::tor::daemon::base

  service { 'tor':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    provider   => 'systemd',
    require    => Package['tor'],
  }
}
