module OperaWatir
  
  module Compat; end
  
  def self.compatiblity!
    include Compat
  end
  
end

require 'operawatir/compat/deprecation'
require 'operawatir/compat/browser'
require 'operawatir/compat/window'
require 'operawatir/compat/collection'
require 'operawatir/compat/element'
require 'operawatir/compat/selector'

module OperaWatir::Compat
  def self.included(klass)
    OperaWatir::Browser.send :include, OperaWatir::Compat::Browser
    OperaWatir::Window.send :include, OperaWatir::Compat::Window
    OperaWatir::Collection.send :include, OperaWatir::Compat::Collection
    OperaWatir::Element.send :include, OperaWatir::Compat::Element
    OperaWatir::Selector.send :include, OperaWatir::Compat::Selector
  end
end

