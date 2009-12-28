require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
 
$LOAD_PATH.unshift('lib')
require 'cellular_map'
 
desc 'Default: run unit tests.'
task :default => [:clean, :test]
 
desc 'Test the cellular map gem.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/test_*.rb'
  t.verbose = true
end

begin
  require 'rcov/rcovtask'
  desc 'Test coverage reports.'
  Rcov::RcovTask.new do |t|
    t.libs << 'test'
    t.pattern = 'test/**/test_*.rb'
    t.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end


desc 'Start an IRB session with all necessary files required.'
task :shell do |t|
chdir File.dirname(__FILE__)
exec 'irb -I lib/ -I lib/cellular_map -r map'
end
 
desc 'Generate documentation for the cellular map gem.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title = 'Cellular Map'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('LICENSE')
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
 
desc 'Clean up files.'
task :clean do |t|
  FileUtils.rm_rf "doc"
  FileUtils.rm_rf "coverage"
  Dir.glob("cellular_map-*.gem").each { |f| FileUtils.rm f }
end
 
include_file_globs = ["README*",
                      "LICENSE",
                      "Rakefile",
                      "{lib,test}/**/*"]
exclude_file_globs = []
spec = Gem::Specification.new do |s|
  s.name = "cellular_map"
  s.version = CellularMap::VERSION
  s.author = "Michel Belleville"
  s.email = "michel.belleville@gmail.com"
  s.homepage = "http://github.com/Bastes/CellularMap/"
  s.platform = Gem::Platform::RUBY
  s.summary = "A simple 2d cellular map."
  s.description = <<-EOF
    This gem aims to offer a very easy to use infinite cellular map allowing
    movement through vectors and use of zones.
  EOF
  s.files = FileList[include_file_globs].to_a - FileList[exclude_file_globs].to_a
  s.require_path = "lib"
  s.test_files = FileList["{test}/**/test_*.rb"].to_a
  s.has_rdoc = true
  s.extra_rdoc_files = ["README"]
  s.rdoc_options << '--line-numbers' << '--inline-source'
  s.add_dependency("thoughtbot-shoulda", ">= 0")
end
 
desc "Print a list of the files to be put into the gem"
task :manifest => :clean do
  spec.files.each do |file|
    puts file
  end
end
 
desc "Generate a gemspec file"
task :gemspec => :clean do
  File.open("#{spec.name}.gemspec", 'w') do |f|
    f.write spec.to_ruby
  end
end
 
desc "Build the gem into the current directory"
task :gem => :gemspec do
  `gem build #{spec.name}.gemspec`
end

