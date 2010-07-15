#
# To change this template, choose Tools | Templates
# and open the template in the editor.


require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/testtask'
require 'spec/rake/spectask'

spec = Gem::Specification.new do |s|
  s.name = 'OperaWatir'
  s.version = '0.2.2.100709'
  s.has_rdoc = false
  #s.extra_rdoc_files = ['README', 'LICENSE']
  s.summary = 'OperaWatir on OperaDriver engine'
  s.description = s.summary
  s.author = 'Deniz Turkoglu'
  s.email = 'dturkoglu@opera.com'
  # s.executables = ['your_executable_here']
  s.files = %w(LICENSE README Rakefile) + Dir.glob("{bin,lib,spec}/**/*")
  s.files.reject! { |fn| fn.include? "main.rb" }
  s.require_path = "lib"
  s.bindir = "bin"
end

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = true
  p.need_zip = true
end

Rake::RDocTask.new do |rdoc|
  files =['README', 'LICENSE', 'INSTALL', 'TUTORIAL', 'lib/**/*.rb']
  rdoc.rdoc_files.add(files)
  rdoc.main = "README" # page to start on
  rdoc.title = "OperaWatir Documentation"
  rdoc.rdoc_dir = 'doc' # rdoc output folder
  rdoc.options = '--line-numbers', '--charset=utf-8'
end

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*.rb']
end

Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*.rb']
end
