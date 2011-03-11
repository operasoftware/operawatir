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
    # @param  [String] URL to load
    # @return [String] text in the address field after the page is loaded
    #                  or a blank string
    # @raise [Exceptions::UnknownObjectException] if the widget could not be found
    #           using the specified method
    def load_page_with_url(url)
      # Must focus field before calling enter_text...
      focus_with_click
      # Enters text in a field and then hits enter
      enter_text_and_hit_enter(url)
    end
    
    #
    # Gets the visible text in the address field
    #
    # @return [String] visible text in address field
    #
    # @raise [Exceptions::UnknownObjectException] if the widget could not be found
    #           using the specified method
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
    def highlighted_text
      element.getAdditionalText()     
    end
    
  end
end
