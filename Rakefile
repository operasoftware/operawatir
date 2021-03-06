# -*- coding: utf-8 -*-
require 'rake/clean'
require 'jeweler'
require 'rspec/core/rake_task'
require 'yard'
require 'ci/reporter/rake/rspec'

require './lib/operawatir/version'

Jeweler::Tasks.new do |gem|
  gem.name    = 'operawatir'
  gem.version = OperaWatir.version
  gem.date    = Date.today.to_s

  gem.authors     = ['Andreas Tolf Tolfsen', 'Chris Lloyd', 'Stuart Knightley', 'Deniz Turkoglu']
  gem.email       = ['andreastt@opera.com', 'christopherl@opera.com', 'stuartk@opera.com', 'dturkoglu@opera.com']
  gem.homepage    = 'http://www.opera.com/developer/tools/operawatir/'
  gem.summary     = 'Toolkit for automating interactions with the Opera web browser.'
  gem.description = <<-EOF
    OperaWatir is a part of the Watir (pronounced water) family of
    free software Ruby libraries for automating web browsers.
    OperaWatir provides a querying engine and Ruby bindings for a
    backend Java library, OperaDriver, for driving the Opera web
    browser.  It aims for full compliancy with the Watir 2 and Watir 3
    specifications.
EOF

  gem.rubyforge_project = gem.name

  gem.platform              = 'jruby'
  gem.has_rdoc              = true
  gem.extra_rdoc_files      = ['README.md']

  gem.add_dependency 'rspec', '~> 2.6.0'  # pessimistic operator, it actually means ['>= 2.6.0', '< 2.7.0']
  gem.add_dependency 'deprecated'

  gem.add_development_dependency 'jeweler'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'BlueCloth', '= 1.0.1'
  gem.add_development_dependency 'yard'
  gem.add_development_dependency 'mongrel', '>= 1.1.5'
  gem.add_development_dependency 'sinatra', '>= 1.1'
  gem.add_development_dependency 'rr'
  gem.add_development_dependency 'clipboard'

  gem.files.exclude '.gitignore'
end

CLEAN.add 'pkg'

RSpec::Core::RakeTask.new(:spec)
task :test => [:"ci:setup:rspec", :spec]

YARD::Rake::YardocTask.new do |t|
  t.options = ['--no-private']
end

task :doc => :yard

CLEAN.add 'doc'
