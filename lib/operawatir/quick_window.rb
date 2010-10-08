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

    ######################################################################
    # Prints out all of the internal information about the window. Used
    # to discover the names of widgets and windows to use in the tests
    #
    def print_window_info
      puts "    Name: " + name
      puts "   Title: " + title
      puts "      ID: " + id.to_s
      puts "    Type: " + type.to_s
      puts "OnScreen: " + on_screen?.to_s
      puts "     Pos: x=" + @elm.getLocation().x.to_s + ", y=" + @elm.getLocation().y.to_s
      puts "    Size: width=" + @elm.getSize().width.to_s + ", height=" + @elm.getSize().height.to_s
      puts ""
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
