module OperaWatir
  class QuickTab < QuickButton
 
    # @private
    # def correct_type? - super works fine here
    
    ######################################################################
    # Clicks the tab button, and waits for the tab to be shown / switches to the page
    #
    # @param [String] win_name name of the window that will be opened (Pass a blank string for any window)
    #
    # @return [int] Window ID of the window shown or 0 if no window is shown
    #
    def focus_with_click
      wait_start
      click 
      wait_for_window_activated("Document Window")
    end
        
    ######################################################################
    # Gets a string representation of the tab button 
    #
    # @return [String] Returns a string representing the tab button
    #
    def to_s
      "TabButton #{name}, visible=#{visible?}, enabled=#{enabled?}, text=#{text}, position=#{row},#{col}"
    end

  end
end