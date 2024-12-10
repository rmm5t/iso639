# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'iso639/version'

Gem::Specification.new do |spec|
  username           = "rmm5t"
  spec.name          = "iso639"
  spec.version       = Iso639::VERSION
  spec.authors       = ["Ryan McGeary"]
  spec.email         = ["ryan@mcgeary.org"]
  spec.description   = %q{ISO 639-1 and ISO 639-2 lookups by name, alpha-2 code, or alpha-3 code}
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/#{username}/#{spec.name}"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.metadata = {
    "bug_tracker_uri"   => "#{spec.homepage}/issues",
    "changelog_uri"     => "#{spec.homepage}/releases",
    "source_code_uri"   => spec.homepage,
    "funding_uri"       => "https://github.com/sponsors/#{username}",
  }

  spec.add_development_dependency "minitest",       "~> 5.0"
  spec.add_development_dependency "rake",           "~> 13.0"
end
