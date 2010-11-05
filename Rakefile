require 'rake/clean'
require 'jeweler'
require 'rspec/core/rake_task'
require 'yard/rake/yardoc_task'

require './lib/operawatir/version'

Jeweler::Tasks.new do |gem|
  gem.name    = 'operawatir'
  gem.version = OperaWatir::VERSION
  gem.date    = Date.today.to_s

  gem.authors     = ['Deniz Turkoglu', 'Andreas Tolf Tolfsen', 'Chris Lloyd']
  gem.email       = ['dturkoglu@opera.com', 'andreastt@opera.com', 'christopherl@opera.com']
  gem.homepage    = 'http://opera.github.com/operawatir'
  gem.summary     = 'OperaWatir on OperaDriver engine'
  gem.description = gem.summary

  gem.rubyforge_project = gem.name

  gem.platform         = 'jruby'
  gem.has_rdoc         = true
  gem.extra_rdoc_files = ['README']

  gem.add_dependency 'rspec', '>= 2'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'yard'
  gem.add_development_dependency 'mongrel', '>= 1.2.0.pre2'
  gem.add_development_dependency 'sinatra', '>= 1.1'
  gem.add_development_dependency 'rr'

  gem.files.exclude '.gitignore'
end

CLEAN.add 'pkg'

RSpec::Core::RakeTask.new do |t|
end

YARD::Rake::YardocTask.new do |t|
  t.options = ['--no-private']
end

task :doc => :yard

CLEAN.add 'doc'

# task :bump do
#   v = ENV['VERSION']
#   abort("usage: rake bump VERSION=\"new version number\"") unless v
# 
#   system "git stash &&
#        echo '#{v}' > VERSION &&
#        git add VERSION &&
#        ! git commit --verbose --message 'Version #{v}.' &&
#        git tag -a '#{v}' &&
#        git push --tags &&
#        git stash apply"
# end
