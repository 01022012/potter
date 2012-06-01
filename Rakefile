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
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "potter"
  gem.homepage = "http://github.com/dexterogieosahon/potter"
  gem.license = "MIT"
  gem.summary = %Q{An attempt to DRY out Planify}
  gem.description = %Q{Moving certain functionality into abstraction}
  gem.email = "dexter.ogie-osahon@live.com"
  gem.authors = ["Dexter Ogie-osahon"]
  # dependencies defined in Gemfile
  gem.add_dependency 'activemodel', '>= 3.0'
end
#Jeweler::RubygemsDotOrgTasks.new --do not want to release to outside world

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

#require 'rcov/rcovtask'
#Rcov::RcovTask.new do |test|
#  test.libs << 'test'
#  test.pattern = 'test/**/test_*.rb'
#  test.verbose = true
#  test.rcov_opts << '--exclude "gems/*"'
#end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "potter #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
