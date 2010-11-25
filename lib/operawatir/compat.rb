require 'operawatir/compat/deprecation'
require 'operawatir/compat/browser'
require 'operawatir/compat/window'

module OperaWatir
  
  def self.compatibility!
    Browser.send :include, Compat::Browser
    Window.send :include, Compat::Window
    
    # TODO Ruby Modules can't override methods defined in their included klass
    # Requiring the files is OK, but there needs to be some way of detecting
    # that we are in compatibility mode.
    
    require 'operawatir/compat/collection'
    require 'operawatir/compat/element'
    require 'operawatir/compat/selector'
  end
  
end
