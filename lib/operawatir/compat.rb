require 'operawatir/compat/deprecation'
require 'operawatir/compat/browser'
require 'operawatir/compat/window'
require 'operawatir/compat/collection'
require 'operawatir/compat/element'
require 'operawatir/compat/selector'

module OperaWatir
  
  def self.compatibility!
    Browser.send :include, Compat::Browser
    Window.send :include, Compat::Window
    Collection.send :include, Compat::Collection
    Element.send :include, Compat::Element
    Selector.send :include, Compat::Selector
  end
  
end
