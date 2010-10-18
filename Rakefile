require "rubygems"
require "rake"
require "rake/clean"
require "rake/gempackagetask"
#require "rake/rdoctask"
require "rake/testtask"
require "yard"
require "spec/rake/spectask"


OPERAWATIR_VERSION = File.read("VERSION").strip

spec = Gem::Specification.new do |s|
  s.name = "OperaWatir"
  s.version = OPERAWATIR_VERSION
  s.has_rdoc = true
#  s.extra_rdoc_files = ["README", "LICENSE"]
  s.summary = "OperaWatir on OperaDriver engine"
  s.description = s.summary
  s.author = "Deniz Turkoglu"
  s.email = "dturkoglu@opera.com"
  s.files = %w(README LICENSE VERSION Rakefile) + Dir.glob("{lib,spec,utils}/**/*")
  s.require_path = "lib"
end

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = true
  p.need_zip = true
end

#Rake::RDocTask.new do |rdoc|
#  files = ["README", "LICENSE", "INSTALL", "lib/**/*.rb"]
#  rdoc.rdoc_files.add(files)
#  rdoc.main = "README" # page to start on
#  rdoc.title = "OperaWatir Documentation"
#  rdoc.rdoc_dir = "doc" # rdoc output folder
#  rdoc.options = "--line-numbers", "--charset=utf-8"
#end
YARD::Rake::YardocTask.new do |t|
  t.files = ['lib/**/*.rb']
end

Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList["spec/**/*.rb"]
end

task :yard do
  sh 'yard doc --no-private --files LICENSE,INSTALL'
end

task :doc => :yard
CLEAN.add 'doc'

task :bump do
  v = ENV["VERSION"]
  abort("usage: rake bump VERSION=\"new version number\"") unless v

  time = Time.new
  date = time.strftime("%Y-%m-%d %H:%M:%S")

  system "git stash &&
       echo '#{v}' > VERSION &&
       git add VERSION &&
       ! git commit --verbose --message 'Version #{v}.' &&
       git tag -a '#{v}' -m 'Version #{v}.  Released #{date}.' &&
       git push --tags &&
       git stash apply"
end

