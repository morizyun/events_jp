# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'events_jp/version'

Gem::Specification.new do |spec|
  spec.name          = 'events_jp'
  spec.version       = EventsJp::VERSION
  spec.authors       = ['morizyun']
  spec.email         = ['merii.ken@gmail.com']
  spec.description   = %q{A Ruby wrapper for atnd/connpass/doorkeeper/zusaar API}
  spec.summary       = %q{A Ruby wrapper for atnd/connpass/doorkeeper/zusaar API}
  spec.homepage      = 'https://github.com/morizyun/events_jp'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0.0'
  spec.add_dependency 'hashie'
  spec.add_dependency 'parallel'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'fakeweb'
  spec.add_development_dependency 'rspec'
end
