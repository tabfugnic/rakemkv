lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rakemkv/version'

Gem::Specification.new do |spec|
  spec.name          = "rakemkv"
  spec.version       = RakeMKV::VERSION
  spec.authors       = ["Eric Collins"]
  spec.email         = ["eric@tabfugni.cc"]
  spec.description   = %q{A fully object oriented wrapper around MakeMKV to help facilitate more programmable backups.}
  spec.summary       = %q{Object oriented wrapper around MakeMKV}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "json", "~> 1.7.7"

  spec.add_development_dependency 'cucumber'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-cucumber'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency "bundler", "~> 1.3.2"
  spec.add_development_dependency "rake"
end
