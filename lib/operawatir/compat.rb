module OperaWatir
  
  module Compat; end
  
  def self.compatiblity!
    include Compat
  end
  
end

require 'operawatir/compat/deprecation'
require 'operawatir/compat/browser'
require 'operawatir/compat/window'
require 'operawatir/compat/selector'
require 'operawatir/compat/collection'
require 'operawatir/compat/element'

module OperaWatir::Compat
  def self.included?(klass)
    puts 'ENTERING COMPATIBILITY MODE',
         '-- should include modules now --'
  end
end

