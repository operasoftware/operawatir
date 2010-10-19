module OperaWatir::DesktopExceptions
  include OperaWatir::Exceptions

  # @example
  #   begin
  #     ...
  #   rescue OperaWatirException
  #   end
  
  # Raised when a method is called on a control that is not visible
  # corresponding element.
  class WidgetNotVisibleException < OperaWatirException; end
  
end
