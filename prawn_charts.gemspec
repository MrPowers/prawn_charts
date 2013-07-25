# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'prawn_charts/version'

Gem::Specification.new do |gem|
  gem.name          = "prawn_charts"
  gem.version       = PrawnCharts::VERSION
  gem.authors       = ["MrPowers"]
  gem.email         = ["matthewkevinpowers@gmail.com"]
  gem.description   = %q{Library to create line graphs in Prawn}
  gem.summary       = %q{Library to create line graphs in Prawn}
  gem.homepage      = ""

  gem.add_dependency "prawn"
  gem.add_development_dependency "rspec"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
