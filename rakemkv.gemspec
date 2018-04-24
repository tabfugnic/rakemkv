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
  spec.homepage      = "https://github.com/tabfugnic/rakemkv"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{spec/})
  spec.require_paths = ["lib"]

  spec.add_dependency "json", "~> 2.1"
  spec.add_dependency "terrapin", "~> 0.6"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.2"
end
