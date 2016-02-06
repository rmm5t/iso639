# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'iso639/version'

Gem::Specification.new do |gem|
  gem.name          = "iso639"
  gem.version       = Iso639::VERSION
  gem.authors       = ["Ryan McGeary"]
  gem.email         = ["ryan@mcgeary.org"]
  gem.description   = %q{ISO 639-1 and ISO 639-2 lookups by name, alpha-2 code, or alpha-3 code}
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/rmm5t/iso639"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "minitest",       "~> 5.0"
  gem.add_development_dependency "rake",           "~> 10.0"
end
