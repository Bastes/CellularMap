# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{cellular_map}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michel Belleville"]
  s.date = %q{2009-12-28}
  s.description = %q{    This gem aims to offer a very easy to use infinite cellular map allowing
    movement through vectors and use of zones.
}
  s.email = %q{michel.belleville@gmail.com}
  s.extra_rdoc_files = ["README"]
  s.files = ["README", "LICENSE", "Rakefile", "lib/cellular_map", "lib/cellular_map/cell.rb", "lib/cellular_map/map.rb", "lib/cellular_map/zone.rb", "lib/cellular_map.rb", "test/cell_test.rb", "test/helper.rb", "test/map_test.rb", "test/zone_test.rb"]
  s.homepage = %q{http://github.com/Bastes/CellularMap/}
  s.rdoc_options = ["--line-numbers", "--inline-source"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A simple 2d cellular map.}
  s.test_files = ["test/cell_test.rb", "test/map_test.rb", "test/zone_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
  end
end
