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
    def load_page_with_url(url)
      # Enters text in a field and then hits enter
      enter_text_and_hit_enter(url)
    end
    
    def visible_text
      element.getVisibleText()
    end
    
    def highlighted_text
      element.getAdditionalText()     
    end
    
  end
end
