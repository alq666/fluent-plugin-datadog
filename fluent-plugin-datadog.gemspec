# -*- encoding: utf-8 -*-
# -*- mode:ruby -*-

Gem::Specification.new do |gem|
  gem.authors       = ["Le-Quoc Alexis"]
  gem.email         = ["alq@datadoghq.com"]
  gem.description   = %q{Output data plugin to Datadog. Send your metrics directly from fluentd}
  gem.summary       = %q{Output data plugin to Datadog}
  gem.homepage      = "https://github.com/alq666/fluent-plugin-datadog"
  gem.licenses      = "Apache-2.0"
  

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "fluent-plugin-datadog"
  gem.require_paths = ["lib"]
  gem.version       = "0.0.2"

  gem.add_development_dependency "flexmock", "~> 1.3"
  gem.add_development_dependency "rspec", "~> 2.11"
  gem.add_runtime_dependency "fluentd", "~> 0.12"
  gem.add_runtime_dependency "dogapi", "~> 1.9"
end
