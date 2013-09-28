require 'fluent/test'
require 'fluent/plugin/out_datadog'

require 'flexmock/test_unit'

class DatadogOutputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  CONFIG = %[
dd_api_key test_dd_api_key
  ]
  
  def create_driver(conf = CONFIG)
    Fluent::Test::BufferedOutputTestDriver.new(Fluent::DatadogOutput) do
      def write(chunk)
        chunk.read
      end

      private

      def check_apikeys
      end
    end.configure(conf)
  end

  def test_configure
    d = create_driver
    assert_equal 'test_dd_api_key', d.instance.dd_api_key
  end
end
