# -*- encoding: utf-8 -*-
# -*- mode:ruby -*-

Gem::Specification.new do |gem|
  gem.authors       = ["Le-Quoc Alexis"]
  gem.email         = ["alq@datadoghq.com"]
  gem.description   = %q{Output data plugin to Datadog}
  gem.summary       = %q{Output data plugin to Datadog}
  gem.homepage      = "https://github.com/datadog/fluent-plugin-datadog"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "fluent-plugin-datadog"
  gem.require_paths = ["lib"]
  gem.version       = "0.0.1"

  gem.add_development_dependency "fluentd"
  gem.add_development_dependency "dogapi"
  gem.add_development_dependency "flexmock"
  gem.add_runtime_dependency "fluentd"
  gem.add_runtime_dependency "dogapi"
end
