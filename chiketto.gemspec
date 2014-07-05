# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chiketto/version'

Gem::Specification.new do |spec|
  spec.name          = "chiketto"
  spec.version       = Chiketto::VERSION
  spec.authors       = ["Chris Radford"]
  spec.email         = ["chris@chrisradford.com"]
  spec.summary       = %q{Chiketto is a ruby gem for interacting with the Eventbrite V3 API}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/chrisradfordltd/chiketto"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "dotenv"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "vcr"
end
