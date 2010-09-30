require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'spec/rake/spectask'
require 'yard'

spec = Gem::Specification.new do |s|
  s.name = 'OperaWatir'
  s.version = File.read('VERSION').strip
  s.has_rdoc = true
  s.extra_rdoc_files = ['README', 'LICENSE']
  s.summary = 'OperaWatir on OperaDriver engine'
  s.description = s.summary
  s.author = 'Deniz Turkoglu'
  s.email = 'dturkoglu@opera.com'
  s.files = %w(README LICENSE VERSION Rakefile) + Dir.glob('{lib,spec,utils}/**/*')
  s.require_path = 'lib'
end

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = true
  p.need_zip = true
end

task :yard do
  sh 'yard doc --no-private --files LICENSE,INSTALL'
end

task :doc => :yard
CLEAN.add 'doc'

Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*.rb']
  t.spec_opts = ['--options spec/spec.opts'] if File.exist?('spec/spec.opts')
end

task :bump do
  v = ENV['VERSION']
  abort("usage: rake bump VERSION=\"new version number\"") unless v

  system "git stash &&
       echo '#{v}' > VERSION &&
       git add VERSION &&
       ! git commit --verbose --message 'Version #{v}.' &&
       git tag -a '#{v}' &&
       git push --tags &&
       git stash apply"
end
