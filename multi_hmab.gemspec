# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "multi_hmab/version"

Gem::Specification.new do |s|
  s.name        = "multi_hmab"
  s.version     = MultiHmab::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jason Tai"]
  s.email       = ["taijcjc@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Funny!}
  s.description = %q{funny!}

  s.rubyforge_project = "multi_hmab"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
