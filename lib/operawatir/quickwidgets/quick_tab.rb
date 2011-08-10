module OperaWatir
  class QuickTab < QuickButton

    # @private
    # Checks the type of the widget is correct
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:tabbutton]
    end

    ######################################################################
    # Drag and drop this tab on tab tab_target
    #
    # @param [QuickTab] tab button to drop this tab on
    #
    # @raise [DesktopExceptions::UnknownObjectException] if the target is not a tab
    #
    def move_with_drag(tab_target)
      raise(Exceptions::UnknownObjectException) unless tab_target.type == :tabbutton
      drag_and_drop_on(tab_target, :center)

      sleep(0.1)
    end

    ######################################################################
    # Drag and drop this tab on another tab to add it to its tab group
    #
    # @param [QuickTab] tab (group) button to drop this tab on
    #
    # @raise [DesktopExceptions::UnknownObjectException] if the target is not a tab
    #
    # @return [int] the number of tabs in this tab group, or 1 if this is not a tab group button,
    #               in which case it represents only 1 tab, itself
    def group_with_drag(tab_target)
      raise(Exceptions::UnknownObjectException) unless tab_target.type == :tabbutton

      # Drop on the edge of a tab to make the grouping work
      drag_and_drop_on(tab_target, :edge)

      sleep(0.1)

      #Get the  number of tabs in the group
      element(true).value
    end


    ######################################################################
    # Clicks the tab button, and waits for the tab to be shown / switches to the page
    #
    # @param [String] win_name name of the window that will be opened (Pass a blank string for any window)
    #
    # @return [int] Window ID of the window activated,
    #               0 if the window is already the active one,
    #               or if no window is active
    #
    # @raise [DesktopExceptions::WidgetNotVisibleException] if the tab button
    #            is not visible
    #
    def activate_tab_with_click
      wait_start
      click
      wait_for_window_activated("Document Window")
    end

    ###########################################################################
    # Double clicks the tab and waits for it to be closed
    #
    # @return [int] Window ID of the window that was closed
    #
    def close_window_with_doubleclick
      wait_start
      click(:left, 2)
      wait_for_window_close("Document Window")
    end

  end
end