module OperaWatir
  
  module Compat; end

  # Switches on compatibility layer (Watir 1 API).
  def self.compatibility!
    require 'operawatir/compat/browser'
    require 'operawatir/compat/element_finders'
    require 'operawatir/compat/window'
    
    Browser.send :include, Compat::Browser
    Window.send :include, Compat::ElementFinders
    Window.send :include, Compat::Window
    Collection.send :include, Compat::ElementFinders
    
    # TODO Ruby Modules can't override methods defined in their included klass
    #   Requiring the files is OK, but there needs to be some way of detecting
    #   that we are in compatibility mode.
    
    require 'operawatir/compat/collection'
    require 'operawatir/compat/element'
  end
  
end
