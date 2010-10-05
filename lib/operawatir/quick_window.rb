module OperaWatir
  class QuickWindow
    include DesktopCommon

    # @private
    def initialize(container, method, selector=nil)
      @container = container
                            
      if method.is_a? Java::ComOperaCoreSystems::QuickWindow
        @elm = method
      else
        @method    = method
        @selector  = selector.to_s
      end
    end

    ######################################################################
    # Checks whether a widget exists or not
    #
    # @return [Boolean] true if the widget exists otherwise false
    #
    def exist?
      !!@elm
      rescue Exceptions::UnknownObjectException
        false
    end
    alias_method :exists?, :exist?
    
    ######################################################################
    # Checks if a widget is visible or not
    #
    # @return [Boolean] true if visible otherwise false
    #
    def visible?
      @elm.isVisible
    end

    ######################################################################
    # Gets the type of a widget
    #
    # @return [Symbol] type of the widget (e.g. :dropdown, :button)
    #
    def type
      WINDOW_ENUM_MAP.invert[@elm.getType]
    end
    
    ######################################################################
    # Get the name of the widget (as it appears in dialog.ini or code)
    #
    # @return [String] name of the widget
    #
    def name
      @elm.getName
    end
    
    ######################################################################
    # Get the name of the widget (as it appears in dialog.ini or code)
    #
    # @return [String] name of the widget
    #
    def title
      @elm.getTitle
    end
        
    
    ######################################################################
    # Get a string representation of the widget
    #
    # @return [String] representation of the widget
    #
    def to_s
      "#{type} #{name}, id=#{id}, on_screen=#{on_screen?}"
    end
    
    def on_screen?
      @elm.isOnScreen
    end


    def id
      @elm.getWindowID
    end

    
private

    def driver
      @container.driver
    end

    #def find
    #  case @method
    #  when :name
    #    @element = driver.findWidgetByName(-1, @selector)
    #    raise(Exceptions::UnknownObjectException, "Element #{@selector} has wrong type") unless correct_type?
    #    @element
    #  end
    #end
  end
end
