# Changelog

All notable changes to this project will be documented in this file. The format
is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this
project adheres to [Semantic Versioning](http://semver.org).

## [3.1.1](https://gitlab.com/shared-puppet-modules-group/tor/-/tags/3.1.1) (2020-12-17)

### Changed

- Refresh Tor Project's GPG key due to expiration.

[Full Changelog](https://gitlab.com/shared-puppet-modules-group/tor/-/compare/3.1.0...3.1.1)


## [3.1.0](https://gitlab.com/shared-puppet-modules-group/tor/-/tags/3.1.0) (2020-11-24)

### Added

- Add new boolean parameter `tor::onion_service::v2_warn`.

[Full Changelog](https://gitlab.com/shared-puppet-modules-group/tor/-/compare/3.0.0...3.1.0)

## [3.0.0](https://gitlab.com/shared-puppet-modules-group/tor/-/tags/3.0.0) (2020-11-01)

### Changed

- Onion Service version 3 is now the default
- Puppet 4.x support has been deprecated

[Full Changelog](https://gitlab.com/shared-puppet-modules-group/tor/-/compare/2.3.0...3.0.0)

## [2.3.0](https://gitlab.com/shared-puppet-modules-group/tor/-/tags/2.3.0) (2020-11-01)

### Added

- Added support for Onion Service version 3 (thanks to ng!)

[Full Changelog](https://gitlab.com/shared-puppet-modules-group/tor/-/compare/2.2.0...2.3.0)

## [2.2.0](https://gitlab.com/shared-puppet-modules-group/tor/-/tags/2.2.0) (2020-10-26)

### Added

- Added support for HTTPTunnel snippet (thanks to keachi!)

[Full Changelog](https://gitlab.com/shared-puppet-modules-group/tor/-/compare/2.1.0...2.2.0)

## [2.1.0](https://gitlab.com/shared-puppet-modules-group/tor/-/tags/2.1.0) (2020-05-10)

### Fixed

- Migrate functions to Puppet 4.x syntax

[Full Changelog](https://gitlab.com/shared-puppet-modules-group/tor/-/compare/2.0.1...2.1.0)

## [2.0.1](https://gitlab.com/shared-puppet-modules-group/tor/-/tags/2.0.1) (2020-05-07)

### Fixed

- Fix upstream apt pinning by adding a negative pin

[Full Changelog](https://gitlab.com/shared-puppet-modules-group/tor/-/compare/2.0.0...2.0.1)

## [2.0.0](https://gitlab.com/shared-puppet-modules-group/tor/-/tags/2.0.0) (2020-04-27)

This module has been extensively re-written for the 2.0.0 version. Even though
most things should work as they did before, we urge you to read the new
documentation and treat this as a new module.

[Full Changelog](https://gitlab.com/shared-puppet-modules-group/tor/-/compare/1.1.0...2.0.0)

## Older versions

The changelog for older versions has been lost in time. Have a look at the git
log, the first commit on this modules dates back to 2010/04/18 :)
