module OperaWatir
  module ClickableItem

    ######################################################################
    # Clicks the button, and waits for loading to finish
    #
    # @return [int] Window ID of the window shown or 0 if no window is shown
    #
    # @raise [DesktopExceptions::WidgetNotVisibleException] if the button
    #            is not visible
    #
    def load_page_with_click
      wait_start
      click
      # Just wait for the load
      wait_for_window_loaded("")
    end

    ######################################################################
    # Clicks the button, and waits for the window with window name
    # win_name to be shown
    #
    # @param [String] win_name name of the window that will be opened (Pass a blank string for any window)
    #
    # @return [int] Window ID of the window shown or 0 if no window is shown
    #
    # @raise [DesktopExceptions::WidgetNotVisibleException] if the button
    #            is not visible
    #
    def open_window_with_click(win_name)
      wait_start
      click
      wait_for_window_shown(win_name)
    end
    alias_method :open_dialog_with_click, :open_window_with_click

    ######################################################################
    # Clicks item and waits for the menu to close
    #
    # @return name of menu closed
    #
    def close_menu_with_click(menu_name)
      wait_start
      click
      wait_for_menu_closed(menu_name)
    end

    ######################################################################
    # Clicks the item, and waits for the menu with menu with name
    # menu_name to be shown
    #
    # @param [String] name of menu that should open
    #
    # @raise [DesktopExceptions::WidgetNotVisibleException] if the button
    #            is not visible
    #
    # @return name of menu opened if it matches the parameter menu_name,
    #           otherwise returns empty string
    #
    def open_menu_with_click(menu_name)
      wait_start
      click
      wait_for_menu_shown(menu_name)
    end


  end
end
