# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'glimmer/launcher'
require 'rake'
require 'juwelier'
Juwelier::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "draw_color_repeat"
  gem.homepage = "http://github.com/AndyObtiva/dcr"
  gem.license = "MIT"
  gem.summary = %Q{Draw Color Repeat}
  gem.description = %Q{Draw Color Repeat is a young child programming language for drawing and coloring with repetition. DCR is a minimal subset of Logo.}
  gem.email = "andy.am@gmail.com"
  gem.authors = ["Andy Maleh"]

  gem.files = Dir['dcr.gemspec', 'README.md', 'VERSION', 'LICENSE.txt', 'app/**/*', 'bin/**/*', 'config/**/*', 'samples/**/*', 'db/**/*', 'docs/**/*', 'fonts/**/*', 'icons/**/*', 'lib/**/*', 'package/**/*', 'script/**/*', 'sounds/**/*', 'vendor/**/*', 'videos/**/*']
  gem.executables = ['dcr']
  gem.require_paths = ['vendor', 'lib', 'app']
  # dependencies defined in Gemfile
end
Juwelier::RubygemsDotOrgTasks.new
require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
  spec.ruby_opts = [Glimmer::Launcher.jruby_os_specific_options]
end

desc "Code coverage detail"
task :simplecov do
  ENV['COVERAGE'] = "true"
  Rake::Task['spec'].execute
end

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "dcr #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'glimmer/rake_task'
Glimmer::RakeTask::Package.javapackager_extra_args =
  " -name 'Draw Color Repeat'" +
  " -title 'Draw Color Repeat'" +
  " -Bmac.CFBundleName='Draw Color Repeat'" +
  " -Bmac.CFBundleIdentifier='org.dcr.application.DrawColorRepeat'"
  # " -BlicenseType=" +
  # " -Bmac.category=" +
  # " -Bmac.signing-key-developer-id-app="
