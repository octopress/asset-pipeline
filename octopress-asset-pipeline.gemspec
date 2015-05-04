# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'octopress-asset-pipeline/version'

Gem::Specification.new do |spec|
  spec.name          = "octopress-asset-pipeline"
  spec.version       = Octopress::AssetPipeline::VERSION
  spec.authors       = ["Brandon Mathis"]
  spec.email         = ["brandon@imathis.com"]
  spec.summary       = %q{Combine and compress CSS and Sass, Javascript and Coffeescript to a single fingerprinted file.}
  spec.homepage      = "https://github.com/octopress/asset-pipeline"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split("\n").grep(%r{^(bin\/|lib\/|assets\/|changelog|readme|license)}i)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "octopress-ink", "~> 1.1.0"
  
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "clash"
  spec.add_development_dependency "rake"

  if RUBY_VERSION >= "2"
    spec.add_development_dependency "pry-byebug"
  end
end
