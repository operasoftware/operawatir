module OperaWatir::Exceptions

  # Superclass for all OperaWatir exceptions.
  #
  # @example
  #   begin
  #     ...
  #   rescue OperaWatirException
  #   end
  class OperaWatirException < RuntimeError; end
  
  # Raised when a method is called on an object which doesn't have a
  # corresponding element.
  class UnknownObjectException < OperaWatirException; end

  # Raised when specifying an unknown way of finding an element.
  #
  # @example
  #   browser.divs(:weird_method, 10)
  class MissingWayOfFindingObjectException < OperaWatirException; end
  
  # Raised when trying to switch to an unknown frame.
  class UnknownFrameException < OperaWatirException; end

  # Raised when performing an action which has not yet been implemented
  # by OperaWatir.
  class NotImplementedException < OperaWatirException; end

  # @todo Document this
  class NoValueFoundException < OperaWatirException; end

  # Raised when trying to perform an action on an element which is
  # disabled.
  class ObjectDisabledException < OperaWatirException; end
  
  # Raised when trying to access a table cell that doesn't exist.
  class UnknownCellException < OperaWatirException; end

end

