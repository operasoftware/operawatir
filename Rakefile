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
  s.version = '0.2.2.100722'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README', 'LICENSE']
  s.summary = 'OperaWatir on OperaDriver engine'
  s.description = s.summary
  s.author = 'Deniz Turkoglu'
  s.email = 'dturkoglu@opera.com'
  s.files = %w(README LICENSE Rakefile) + Dir.glob('{lib,spec,utils}/**/*')
  s.require_path = 'lib'
end

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = true
  p.need_zip = true
end

Rake::RDocTask.new do |rdoc|
  files = ['README', 'LICENSE', 'INSTALL', 'lib/**/*.rb']
  rdoc.rdoc_files.add(files)
  rdoc.main = 'README' # page to start on
  rdoc.title = 'OperaWatir Documentation'
  rdoc.rdoc_dir = 'doc' # rdoc output folder
  rdoc.options = '--line-numbers', '--charset=utf-8'
end

Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*.rb']
end

