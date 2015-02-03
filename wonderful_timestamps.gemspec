# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wonderful_timestamps/version'

Gem::Specification.new do |spec|
  spec.name          = "wonderful_timestamps"
  spec.version       = WonderfulTimestamps::VERSION
  spec.authors       = ["Vincent Franco"]
  spec.email         = ["vince@freshivore.net"]
  spec.summary       = %q{Legacy dcreate and dupdate fields for Wonderful Union}
  spec.description   = %q{Victims of their own success, this is a shim for migration}
  spec.homepage      = ""

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_dependency "activerecord"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "activerecord-nulldb-adapter"
end
