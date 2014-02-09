require 'fluent/test'
require 'fluent/plugin/out_datadog'
require 'dogapi'
require 'time'

# Disable Test::Unit
module Test::Unit::RunCount; def run(*); end; end

RSpec.configure do |config|
  config.before(:all) do
    Fluent::Test.setup
  end
end

def run_driver(options = {})
  options = options.dup

  dd_api_key = options[:dd_api_key] || 'test_dd_api_key'

  option_keys = [
    :dd_app_key,
    :host,
  ]

  additional_options = option_keys.map {|key|
    if options[key]
      "#{key} #{options[key]}"
    end
  }.join("\n")

  tag = options[:tag] || 'test.default'

  fluentd_conf = <<-EOS
type datadog
dd_api_key #{dd_api_key}
#{additional_options}
  EOS

  tag = options[:tag] || 'test.default'
  driver = Fluent::Test::OutputTestDriver.new(Fluent::DatadogOutput, tag).configure(fluentd_conf)

  driver.run do
    dog = driver.instance.instance_variable_get(:@dog)
    yield(driver, dog)
  end
end
