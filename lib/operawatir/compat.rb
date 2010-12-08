require 'operawatir/compat/deprecation'
require 'operawatir/compat/browser'
require 'operawatir/compat/element_finders'

module OperaWatir
  
  def self.compatibility!
    Browser.send :include, Compat::Browser
    Window.send :include, Compat::ElementFinders
    Collection.send :include, Compat::ElementFinders
    
    # TODO Ruby Modules can't override methods defined in their included klass
    # Requiring the files is OK, but there needs to be some way of detecting
    # that we are in compatibility mode.
    
    require 'operawatir/compat/collection'
    require 'operawatir/compat/element'
  end
  
end
