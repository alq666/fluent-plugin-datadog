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
class Fluent::DatadogOutput < Fluent::Output
  Fluent::Plugin.register_output('datadog', self)

  config_param :dd_api_key, :string

  def initialize
    super
    require 'dogapi'
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

    @dog = Dogapi::Client.new(@dd_api_key)
  end

  def emit(tag, es, chain)
    begin
      $log.trace "Send metrics to Datadog"
      es.each do |tstamp, record|
        record.each do |key, value|
          $log.trace "Sending #{key}: #{value}@#{tstamp}"
          #@dog.emit_points(key, [tstamp, value])
        end
      end
    rescue
      $log.warn "Cannot send metrics to Datadog. Skipping..."
    end
    
    # Done reporting metrics
    chain.next
  end

  def map_key(key, pattern, replace)
    unless pattern =~ key
      nil
    else
      key.sub(pattern, replace)
    end
  end
end
