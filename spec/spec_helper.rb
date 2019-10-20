require 'bundler/setup'
require 'webmock/rspec'
require 'vcr'
require 'rubbl'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  VCR.configure do |vcr_config|
    vcr_config.cassette_library_dir = 'fixtures/cassettes'
    vcr_config.hook_into :webmock
  end

  # Sandbox creds
  config.before(:each) do
    if File.exists? "config/rspec_vars.yml"
      vars = YAML.load_file "config/rspec_vars.yml"
      @api_key = vars['api_key']
    end
  end
end
