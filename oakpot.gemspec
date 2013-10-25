# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oakpot/version'

Gem::Specification.new do |spec|
  spec.name          = "oakpot"
  spec.version       = Oakpot::VERSION
  spec.authors       = ["Thomas Riboulet"]
  spec.email         = ["riboulet+gem@gmail.com"]
  spec.description   = %q{A small gem to wrap calls to Twilio API and add handy methods to an object}
  spec.summary       = %q{Call wrapper around Twilio calls and sms calls}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'faker'
  spec.add_dependency 'twilio-ruby'
  spec.add_dependency 'faraday'
  spec.add_dependency 'activesupport'
end
