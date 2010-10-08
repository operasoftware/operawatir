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
        @selector  = selector.to_s
      end
    end

    ######################################################################
    # Checks whether a widget exists or not
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
    # Checks if a widget is visible or not
    #
    # @return [Boolean] true if visible otherwise false
    #
    def visible?
      element.isVisible
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
      element.getName
    end
    
    ######################################################################
    # Get the name of the widget (as it appears in dialog.ini or code)
    #
    # @return [String] name of the widget
    #
    def title
      element.getTitle
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
      element.isOnScreen
    end


    def id
      element.getWindowID
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

    # Gets the window id to use for the search
    def get_window_id
      element.getWindowID
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
      end
      raise(Exceptions::UnknownObjectException, "Window #{@selector} not found using #{@method}") unless @element 
      @element
    end
  end
end
