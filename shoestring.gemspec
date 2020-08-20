# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shoestring/version'

Gem::Specification.new do |spec|
  spec.name          = "shoestring"
  spec.version       = Shoestring::VERSION
  spec.authors       = ["Caleb Woods"]
  spec.email         = ["calebawoods@gmail.com"]
  spec.description   = %q{Helps you manage development dependencies for your Rails app}
  spec.summary       = %q{See Github page for examples}
  spec.homepage      = "http://rolemodelsoftware.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "powder", "~> 0.4.0"

  spec.add_development_dependency "bundler", "~> 2.1.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "minitest", "~> 5.0.8"
end
