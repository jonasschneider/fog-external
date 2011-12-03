# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "fog-external"
  s.version     = "0.0.3"
  s.authors     = ["Jonas Schneider"]
  s.email       = ["mail@jonasschneider.com"]
  s.homepage    = ""
  s.summary     = %q{Fog::Storage with a consistent API}
  s.description = %q{Use a custom backend (such as BERTRPC) with Fog:Storage.}


  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency('rake')
  s.add_development_dependency "rspec"
  
  s.add_runtime_dependency "fog"
end
