lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "gem_master/version"

Gem::Specification.new do |spec|
  spec.name          = "gem_master"
  spec.version       = GemMaster::VERSION
  spec.authors       = ["Colin Kelley"]
  spec.email         = ["colin@invoca.com"]

  spec.summary       = "Support for Gemfile.master that centralizes Gemfile gem settings"
  spec.homepage      = "https://github.com/invoca/gem_master"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1"
  spec.add_development_dependency "rake", "~> 10"
  spec.add_development_dependency "minitest", "~> 5.0"
end
