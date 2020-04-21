# @summary Main class, includes all other classes.
#
# @param arm
#   Install tor-arm.
#
# @param arm_package
#   Name of the specific package to install for tor-arm.
#
# @param arm_version
#   The specific version of tor-arm that should be installed.
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
# @param torsocks_version
#   The specific version of torsocks that should be installed.
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
  Boolean $arm,
  String  $arm_package,
  String  $arm_version,
  Boolean $automap_hosts_on_resolve,
  Stdlib::Unixpath $data_dir,
  String  $config_file,
  Array   $log_rules,
  Boolean $safe_logging,
  Boolean $torsocks,
  String  $torsocks_version,
  String  $version,
  Boolean $use_bridges,
  Boolean $use_upstream_repository,
  String  $upstream_release,
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
