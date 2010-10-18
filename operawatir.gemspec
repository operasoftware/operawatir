require 'lib/operawatir/version'

@spec = Gem::Specification.new do |s|
  s.name    = 'operawatir'
  s.version = OperaWatir::VERSION
  s.date    = Date.today.to_s
  
  s.authors     = ['Deniz Turkoglu', 'Andreas Tolf Tolfsen', 'Chris Lloyd']
  s.email       = ['dturkoglu@opera.com', 'andreastt@opera.com', 'christopherl@opera.com']
  s.homepage    = 'http://opera.github.com/operawatir'
  s.summary     = 'OperaWatir on OperaDriver engine'
  s.description = s.summary

  s.rubyforge_project = s.name
  
  s.platform         = 'jruby'
  s.has_rdoc         = true
  s.extra_rdoc_files = ['README']
  
  s.require_path = 'lib'
  s.files        = %w(README Rakefile) + Dir['lib/**/*']  
end

