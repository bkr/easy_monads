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
  gem.name = "easy_monads"
  gem.homepage = "https://github.com/bkr/easy_monads"
  gem.license = "MIT"
  gem.summary = "EasyMonads is a simple implementation of monads for Ruby"
  gem.description = <<EOS
EasyMonads is a gem for Ruby that provides a simple implementation of monads.  It also provides a useful example of
monads in the form of Option (similar to Scala's Option) which provides Some and None classes.

Developement for EasyMonads is sponsored by BookRenter.com and it is released under an MIT-style license
EOS
  gem.email = "stephen.sloan@bookrenter.com"
  gem.authors = ["Stephen Sloan"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "easy_monads #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
