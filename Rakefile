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
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "Cellular Map v#{version}"
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('LICENSE')
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
 
desc 'Clean up files.'
task :clean do |t|
  FileUtils.rm_rf "rdoc"
  FileUtils.rm_rf "coverage"
  Dir.glob("cellular_map-*.gem").each { |f| FileUtils.rm f }
end
 
begin
  require 'jeweler'
  include_file_globs = ["README*",
                        "LICENSE",
                        "Rakefile",
                        "{lib,test}/**/*"]
  exclude_file_globs = []
  Jeweler::Tasks.new do |gem|
    gem.name = "cellular_map"
    gem.authors = ["Michel Belleville"]
    gem.email = "michel.belleville@gmail.com"
    gem.homepage = "http://github.com/Bastes/CellularMap/"
    gem.platform = Gem::Platform::RUBY
    gem.summary = "A simple 2d cellular map."
    gem.description = <<-EOF
      This gem aims to offer a very easy to use infinite cellular map allowing
      movement through vectors and use of zones.
    EOF
    gem.files = FileList[include_file_globs].to_a - FileList[exclude_file_globs].to_a
    gem.require_path = "lib"
    gem.test_files = FileList["{test}/**/test_*.rb"].to_a
    gem.has_rdoc = true
    gem.extra_rdoc_files = ["README*"]
    gem.rdoc_options << '--line-numbers' << '--inline-source'
    gem.add_development_dependency("thoughtbot-shoulda", ">= 0")
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
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

