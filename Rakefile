require 'rubygems'
require 'bundler/setup'
Bundler.require

require 'rake/clean'
require 'rake/gempackagetask'
require 'rspec/core/rake_task'
require 'yard/rake/yardoc_task'

def name
  @name ||= File.basename(Dir['*.gemspec'].first, '.gemspec')
end

def gemspec_file
  "#{name}.gemspec"
end

def spec
  @spec
end

load(gemspec_file)


Rake::GemPackageTask.new(spec) do |t|
  t.need_tar = true
  t.need_zip = true
end

CLEAN.add 'pkg'


RSpec::Core::RakeTask.new do |t|
end


YARD::Rake::YardocTask.new do |t|
  t.options = ['--no-private']
  t.files   = spec.files
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
