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
    # @return [Boolean] true if the window exists otherwise false
    #
    def exist?
      !!element
      rescue Exceptions::UnknownObjectException
        false
    end
    alias_method :exists?, :exist?
    
    ######################################################################
    #
    # @return [Boolean] true if window is active
    #
    def active?
      element.isActive()
    end
    
    ######################################################################
    # Gets the type of a window
    #
    # @return [Symbol] type of the window 
    #
    # @raise [Exceptions::UnknownObjectException] if the window could not be found
    #           using the specified method
    def type
      return WINDOW_ENUM_MAP.invert[@elm.getType] unless @elm == nil
      return WINDOW_ENUM_MAP.invert[element.getType] 
    end
    
    ######################################################################
    # Gets the name of the window
    #
    # @return [String] name of the window
    #
    # @raise [Exceptions::UnknownObjectException] if the window could not be found
    #           using the specified method
    def name
      element.getName
    end
    
    ######################################################################
    # Gets the title of the window
    #
    # @return [String] title of window
    #
    # @raise [Exceptions::UnknownObjectException] if the window could not be found
    #           using the specified method
    def title
      element.getTitle
    end
        
    
    ######################################################################
    # Gets a string representation of the window
    #
    # @return [String] representation of the window
    #
    # @raise [Exceptions::UnknownObjectException] if the window could not be found
    #           using the specified method
    def to_s
      "#{type} #{name}, title=#{title}, id=#{id}, on_screen=#{on_screen?}, active=#{active?}"
    end
    
    ######################################################################
    #
    # @return [bool] true if window is on screen
    #
    # @raise [Exceptions::UnknownObjectException] if the window could not be found
    #
    def on_screen?
      element.isOnScreen
    end
    
    ######################################################################
    # Gets this windows window id
    #
    # @return [int] the windows window_id
    #
    # @raise [Exceptions::UnknownObjectException] if the window could not be found
    #
    def window_id
      element.getWindowID
    end
    
    alias_method :id, :window_id
        
    ######################################################################
    # Prints out all of the internal information about the window. Used
    # to discover the names of widgets and windows to use in the tests.
    #
    # @raise [Exceptions::UnknownObjectException] if the window could not be found
    #           
    #@private
    def print_window_info
      puts window_info_string
    end
    
    ########################################################################
    #
    # @return width of window
    #
    def width
      element.getRect().width
    end

    ########################################################################
    #
    # @return height of window
    #
    def height
      element.getRect().height
    end

    #@private
    def x
      element.getRect().x
    end

    #@private
    def y
      element.getRect().y
    end
  
    ######################################################################
    # Returns a string of the internal information about the window. Used
    # to discover the names of widgets and windows to use in the tests.
    #
    # @raise [Exceptions::UnknownObjectException] if the window could not be found
    #
    def window_info_string
      "    Name: " + name +
      "\n   Title: " + title +
      "\n  Active: " + active?.to_s + 
      "\n      ID: " + id.to_s +
      "\n    Type: " + type.to_s +
      "\nOnScreen: " + on_screen?.to_s +
      "\n     Pos: x=" + element.getRect().x.to_s + ", y=" + element.getRect().y.to_s +
      "\n    Size: width=" + element.getRect().width.to_s + ", height=" + element.getRect().height.to_s + "\n"
    end

    # @private    
    def driver
      @container.driver
    end
    
    #TODO: common with widget
    ##################################################################
    #
    #  quick_widgets
    #
    # @example
    #     browser.quick_window(:name, "Document Window").quick_widgets
    # @note
    #   You can also retrieve only widgets of a given type, using for example
    #    browser.quick_window(:name, "Document Window").quick_toolbars
    #
    # @return array of widgets in this window
    #
    def quick_widgets
      widgets(window_id)
    end
  
    WIDGET_ENUM_MAP.keys.each do |widget_type|
      my_type = "quick_" << widget_type.to_s
      type = my_type
      if my_type == "quick_search" || my_type == "quick_checkbox"
        my_type << "es"
      else
        my_type << "s"
      end
      define_method(my_type.to_sym) do #|win|
        quick_widgets.select { |w| w.type == widget_type and w.parent_name == name }
      end
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
      #puts "<find> Find Window by " + @method.to_s + ", selector = " + @selector.to_s
      case @method
      when :name
        # Use active window when specifying by name "Document Window"
        # and not the first if there are more than one
        active_window_id = driver.getActiveQuickWindowID()
        name = driver.getQuickWindowName(active_window_id);
        if (@selector == "Document Window" && name == "Document Window")
          @element = driver.findWindowById(driver.getActiveQuickWindowID())
        else
          @element = driver.findWindowByName(@selector)
        end
      when :id
        @element = driver.findWindowById(@selector)
      end
      raise(Exceptions::UnknownObjectException, "Window #{@selector} not found using #{@method}") unless @element 
      @element
    end
  end
end
