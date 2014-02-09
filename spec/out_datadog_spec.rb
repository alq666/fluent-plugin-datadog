describe Fluent::DatadogOutput do
  let(:time) {
    Time.parse('2014-02-08 04:14:15 UTC').to_i
  }

  it 'should receive an API key' do
    Dogapi::Client.should_receive(:new).with("test_dd_api_key")
    run_driver {|d, dog| }
  end

  it 'should receive an APP key' do
    Dogapi::Client.should_receive(:new).with("test_dd_api_key", "test_dd_api_key")
    run_driver(:dd_app_key => "test_dd_api_key") {|d, dog| }
  end

  it 'should be called emit_points' do
    run_driver do |d, dog|

      dog.should_receive(:emit_points).with(
        "some.metric.nam",
        [[Time.parse("2014-02-08 04:14:15 UTC"), 50.0],
         [Time.parse("2014-02-08 04:14:15 UTC"), 100.0]],
        {"tags"=>["test.default"]}
      )

      d.emit({"metric" => "some.metric.nam", "value" => 50.0}, time)
      d.emit({"metric" => "some.metric.nam", "value" => 100.0}, time)
    end
  end
end
