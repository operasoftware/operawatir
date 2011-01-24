module OperaWatir
  class QuickWindow
    include DesktopCommon
    include DesktopContainer

    # @private
    def initialize(container, method, selector=nil)
      @container = container
                            
      if method.is_a? Java::ComOperaCoreSystems::QuickWindow
        @elm = method
      else
        @method    = method
        @selector  = selector
      end
    end

    ######################################################################
    # Checks whether a window exists or not
    #
    # @return [Boolean] true if the widget exists otherwise false
    #
    def exist?
      !!element
      rescue Exceptions::UnknownObjectException
        false
    end
    alias_method :exists?, :exist?
    
    ######################################################################
    # Gets the type of a window
    #
    # @return [Symbol] type of the window (e.g. :dropdown, :button)
    #
    def type
      return WINDOW_ENUM_MAP.invert[@elm.getType] unless @elm == nil
      return WINDOW_ENUM_MAP.invert[element.getType] 
    end
    
    ######################################################################
    # Gets the name of the window
    #
    # @return [String] name of the widget
    #
    # @raise [Exceptions::UnknownObjectException] if the widget could not be found
    #           using the specified method
    def name
      element.getName
    end
    
    ######################################################################
    # Gets the title of the window
    #
    # @return [String] title of window
    #
    # @raise [Exceptions::UnknownObjectException] if the widget could not be found
    #           using the specified method
    def title
      element.getTitle
    end
        
    
    ######################################################################
    # Gets a string representation of the window
    #
    # @return [String] representation of the widget
    #
    # @raise [Exceptions::UnknownObjectException] if the widget could not be found
    #           using the specified method
    def to_s
      "#{type} #{name}, title=#{title}, id=#{id}, on_screen=#{on_screen?}"
    end
    
    ######################################################################
    #
    # @return [bool] true if window is on screen
    #
    # @raise [Exceptions::UnknownObjectException] if the widget could not be found
    #           using the specified method
    def on_screen?
      element.isOnScreen
    end
    
    alias_method :visible?, :on_screen?

    ######################################################################
    # Gets this windows window id
    #
    # @return [int] the windows window_id
    #
    # @raise [Exceptions::UnknownObjectException] if the widget could not be found
    #           using the specified method
    def window_id
      element.getWindowID
    end
    
    alias_method :id, :window_id
        
    ######################################################################
    # Prints out all of the internal information about the window. Used
    # to discover the names of widgets and windows to use in the tests
    #
    # @raise [Exceptions::UnknownObjectException] if the widget could not be found
    #           using the specified method
    def print_window_info
      puts "    Name: " + name
      puts "   Title: " + title
      puts "      ID: " + id.to_s
      puts "    Type: " + type.to_s
      puts "OnScreen: " + on_screen?.to_s
      puts "     Pos: x=" + element.getRect().x.to_s + ", y=" + element.getRect().y.to_s
      puts "    Size: width=" + element.getRect().width.to_s + ", height=" + element.getRect().height.to_s
      puts ""
    end

    # @private    
    def driver
      @container.driver
    end

private

    # Gets the parent widget name of which there is none here
    def parent_widget
      nil
    end

    # Return the element
    def element(refresh = false)
      if (@elm == nil || refresh == true)
       @elm = find
      end
      
      raise(Exceptions::UnknownObjectException, "Window #{@selector} not found using #{@method}") unless @elm 
      @elm
    end
    
    # Finds the element on the page.  
    def find
      case @method
      when :name
        @element = driver.findWindowByName(@selector)
      when :id
        @element = driver.findWindowById(@selector)
      end
      raise(Exceptions::UnknownObjectException, "Window #{@selector} not found using #{@method}") unless @element 
      @element
    end
  end
end
