$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "easy_admin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "easy_admin"
  s.version     = EasyAdmin::VERSION
  s.authors       = ["Shevaun Coker", "Nigel Ramsay"]
  s.email         = ["contact@abletech.co.nz"]
  s.description   = %q{Common Admin maintenance screens}
  s.summary       = %q{View, delete and retry queued Delayed Jobs from an admin interface}

  s.files = Dir["{app,config,db,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md", "CHANGELOG.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.2"
  s.add_dependency "will_paginate", ">= 3.0.5"

  s.add_development_dependency "sqlite3"
end
