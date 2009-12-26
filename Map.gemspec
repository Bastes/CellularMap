# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{Map}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michel Belleville"]
  s.autorequire = %q{map}
  s.date = %q{2009-12-26}
  s.email = %q{michel.belleville@gmail.com}
  s.extra_rdoc_files = ["README"]
  s.files = ["README", "LICENSE", "Rakefile", "lib/map", "lib/map/cell.rb", "lib/map/map.rb", "lib/map/zone.rb", "lib/map.rb", "test/cell_test.rb", "test/map_test.rb", "test/helper.rb", "test/zone_test.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/Bastes/Map/}
  s.rdoc_options = ["--line-numbers", "--inline-source"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A simple 2d cellular maps.}
  s.test_files = ["test/cell_test.rb", "test/map_test.rb", "test/zone_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
  end
end
