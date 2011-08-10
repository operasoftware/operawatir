module OperaWatir
  class QuickMenu < QuickWidget #??
    # @private
    # Checks the type of the widget is correct
    #def correct_type?
    #  @element.getType == WIDGET_ENUM_MAP[:menu]
    #end

    # @private
    # window_id is set if constructor is called on a (parent) window
    # location if set is this is called on a (parent) widget
    def initialize(container, method, selector=nil, location=nil)

      @container = container

      if method.is_a? Java::ComOperaCoreSystems::QuickMenu
        @elm = method
      else
        @method    = method
        @selector  = selector
        @location  = location
      end
    end

    ####################################################################
    #
    # @example
    #   browser.quick_menu(:name, "Browser Button Menu Bar").name.should == "Browser Button Menu Bar"
    #
    # @return the name of the menu (as found in standard_menu.ini)
    #
    def name
      element.getName
    end


    #######################################################################
    #
    # @return the window_id of the window the menu is attached to
    #
    # Note: This only makes sense for the menubars (and not on mac where there is
    #           only one menubar)
    # Note: This makes it possible to distinguish between menubars in different
    #         main windows
    #
    # @example:
    #   browser.quick_menu(:name, "Main Menu").window_id
    #   browser.quick_window(:id, <id>).quick_menu(:name, "Browser File Menu")...
    #
    #
    def window_id
      element.getParentWindowId()
    end

    #######################################################################
    #
    # @return string representation of menu
    #
    def to_s
      window = window_id > 0 ? "window_id #{window_id}" : ""
      "QUICKMENU #{name} #{window}" # TODO: Add rect
    end

    ########################################################################
    #
    # @return width of widget
    #
    def width
      element.getRect().width
    end

    ########################################################################
    #
    # @return height of widget
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

    ########################################################################
    #
    # @return true if this menu has one or more submenus
    #
    # @example
    #     menu.should be_parentmenu
    #
    def parentmenu?
      element.getItemList().each do |item|
        if item.hasSubMenu()
          return true
        end
      end
      false
    end

    ########################################################################
    #
    # @return array of all menuitems in this menu
    #
    # @example:
    #    menu.menuitems.select { |item| item.menu != menu.name }.should be_empty
    #    menu.menuitems.each { | item | puts item.name }
    #
    def quick_menuitems
      element.getItemList().map do |java_item|
        QuickMenuItem.new(self,java_item)
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

    private

    # Finds the element on the page.
    def find
      #If @method set and we do new find because of refresh, we need to get @selector first
      #Have the java object because the construct was done on it
      #if @selector == nil && @elm != nil
      #  set_selector
      #end
      #puts "\n<find> Find Menu by " + @method.to_s + ", " + @selector.to_s + ", " + @location.to_s
      case @method
      when :name
        if @location != nil && @location >= 0
          @element = driver.getQuickMenu(@selector, @location)
        else
          @element = driver.getQuickMenu(@selector)
        end
      end
      raise(Exceptions::UnknownObjectException, "Element #{@selector} not found using #{@method}") unless @element
      @element
    end

  end
end
