# frozen_string_literal: true

require "bundler/setup"
require "friendly_shipping"
require "vcr"
require "dotenv"
require "physical/spec_support/factories"

Dotenv.load

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.filter_sensitive_data('<SHIPENGINE_API_KEY>') { ENV['SHIPENGINE_API_KEY'] }
  c.filter_sensitive_data('<UPS_LOGIN>') { ENV['UPS_LOGIN'] }
  c.filter_sensitive_data('<UPS_KEY>') { ENV['UPS_KEY'] }
  c.filter_sensitive_data('<UPS_PASSWORD>') { ENV['UPS_PASSWORD'] }
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def gem_root
  spec = Gem::Specification.find_by_name("friendly_shipping")
  spec.gem_dir
end
