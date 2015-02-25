#
# Fluent::DatadogOutput
#
# Copyright (C) 2013 Datadog, Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#
class Fluent::DatadogOutput < Fluent::BufferedOutput
  include Fluent::SetTimeKeyMixin
  include Fluent::SetTagKeyMixin

  Fluent::Plugin.register_output('datadog', self)

  unless method_defined?(:log)
    define_method('log') { $log }
  end

  config_set_default :include_time_key, true
  config_set_default :include_tag_key, true

  config_param :dd_api_key, :string
  config_param :dd_app_key, :string, :default => nil
  config_param :host, :string, :default => nil

  def initialize
    super
    require 'dogapi'
    require 'time'
  end

  def start
    super
  end

  def shutdown
    super
  end

  def configure(conf)
    super

    if @dd_api_key.nil?
      raise Fluent::ConfigError, "missing Datadog API key"
    end

    client_args = [@dd_api_key]
    client_args << @dd_app_key if @dd_app_key
    @dog = Dogapi::Client.new(*client_args)
  end

  def format(tag, time, record)
    record.to_msgpack
  end

  def write(chunk)
    enum = chunk.to_enum(:msgpack_each)

    enum.select {|record|
      unless record['metric']
        log.warn("`metric` key does not exist: #{record.inspect}")
      end

      record['metric']
    }.chunk {|record|
      record.values_at('metric', 'tag', 'host', 'type')
    }.each {|i, records|
      metric, tag, host, type = i
      host = @host unless host

      points = records.map do |record|
        time = Time.parse(record['time'])
        value = record['value']
        [time, value]
      end

      options = {}
      options[:tags] = [tag] if tag
      options[:host] = host if host
      options[:type] = type if type

      code, response = @dog.emit_points(metric, points, options)
      if code.to_i / 100 != 2
        raise("Datadog API returns error on emit_points: #{code}: #{response.inspect}")
      end
    }
  end
end
