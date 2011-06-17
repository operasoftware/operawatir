module OperaWatir
  class QuickAddressField < QuickEditField

    # Checks the type of the widget is correct
    #
    # @private
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:addressfield]
    end

    # Enters the url into the address field, and waits for page loading 
    # to finish
    #
    # @example (with RSpec)
    #    addressfield.load_page_with_url("opera:debug").should == "opera:debug"
    #
    # @param  [String] URL to load
    # @return [String] text in the address field after the page is loaded
    #                  or a blank string
    # @raise [Exceptions::UnknownObjectException] if the widget could not be found
    #           using the specified method
    #
    def load_page_with_url(url)
      # Must focus field before calling enter_text...
      focus_with_click
      
      # Enters text in a field and then hits enter
      enter_text_and_hit_enter(url)
    end
    
    ######################################################################
    # Clicks the button, and waits for the window with window name 
    # win_name to be shown
    #
    # @example 
    #     addressfield.open_menu_with_rightclick("Toolbar Edit Item Popup Menu")
    #
    # @param [String] win_name name of the window that will be opened (Pass a blank string for any window)
    #
    # @return [int] Window ID of the window shown or 0 if no window is shown
    #
    # @raise [DesktopExceptions::WidgetNotVisibleException] if the button
    #            is not visible
    #
    def open_menu_with_rightclick(menu_name)
      wait_start
      click(:right)
      wait_for_menu_shown(menu_name)
    end

    
    #
    # Gets the visible text in the address field
    #
    # @return [String] visible text in address field
    #
    # @raise [Exceptions::UnknownObjectException] if the widget could not be found
    #           using the specified method
    #
    def visible_text
      element.getVisibleText()
    end
    
    #
    # Gets the highlighted text in the address field
    #
    # @return [String] higlighted text in address field, if any, else empty
    #
    # @raise [Exceptions::UnknownObjectException] if the widget could not be found
    #           using the specified method
    #
    def highlighted_text
      element.getAdditionalText()     
    end
    
  end
end
