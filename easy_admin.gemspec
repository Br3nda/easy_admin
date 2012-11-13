$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "easy_admin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "easy_admin"
  s.version     = EasyAdmin::VERSION
  s.authors       = ["Shevaun Coker"]
  s.email         = ["shevaun.coker@abletech.co.nz"]
  s.description   = %q{Common Admin maintenance screens}
  s.summary       = %q{View, delete and retry queued Delayed Jobs from an admin interface}

  s.files = Dir["{app,config,db,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.0"

  s.add_development_dependency "sqlite3"
end
