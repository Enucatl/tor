#! /usr/bin/env ruby -S rspec
dir = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift File.join(dir, 'lib')

# So everyone else doesn't have to include this base constant.
module PuppetSpec
  FIXTURE_DIR = File.join(dir = File.expand_path(File.dirname(__FILE__)), "fixtures") unless defined?(FIXTURE_DIR)
end

require 'puppet'
require 'rspec-puppet'
require 'puppetlabs_spec_helper/module_spec_helper'
require 'mocha/api'
require 'puppetlabs_spec_helper_clone'


RSpec.configure do |config|

  config.mock_with :mocha

  config.before :each do
    # Ensure that we don't accidentally cache facts and environment between
    # test cases.  This requires each example group to explicitly load the
    # facts being exercised with something like
    # Facter.collection.loader.load(:ipaddress)

    RSpec::Mocks.setup
  end

  config.after :each do
    RSpec::Mocks.verify
    RSpec::Mocks.teardown
  end
end


# hack to enable all the expect syntax (like allow_any_instance_of) in rspec-puppet examples
RSpec::Mocks::Syntax.enable_expect(RSpec::Puppet::ManifestMatchers)

# Helper class to test handling of arguments which are derived from string
class AlsoString < String
end
