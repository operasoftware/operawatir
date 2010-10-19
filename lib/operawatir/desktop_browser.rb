module OperaWatir
  class DesktopBrowser < Browser
    include DesktopContainer
    include DesktopCommon
    
    # @private
    def initialize (executable_location = nil, *arguments)
      if executable_location.nil?
        @driver = OperaDesktopDriver.new
      else
        @driver = OperaDesktopDriver.new(executable_location, arguments.to_java(:String))
      end
    end
      
    ######################################################################
    # Executes the action given by action_name, and waits for
    # the window with window name win_name to be shown
    #
    # @example
    #   $browser.open_window_with_action("New Preferences Dialog", "Show preferences")
    #   $browser.open_window_with_action("New Preferences Dialog", "Show preferences", "1")
    #
    # @param [String] win_name    name of the window that will be opened (Pass a blank string for any window)
    # @param [String] action_name name of the action to execute to open the window
    # @param [String] param       optional parameter(s) to be supplied with the Opera action.
    #
    # @return [int] Window ID of the window shown or 0 if no window is shown
    #
    def open_window_with_action(win_name, action_name, *params)
      wait_start
      @driver.operaDesktopAction(action_name, params.to_java(:String))
      wait_for_window_shown(win_name)
    end
    
    alias_method :open_dialog_with_action, :open_window_with_action
    
    ######################################################################
    # Presses the key, with optional modifiers, and waits for
    # the window with window name win_name to be shown
    #
    # @example
    #   $browser.open_window_with_key_press("New Preferences Dialog", "F12")
    #   $browser.open_window_with_key_press("New Preferences Dialog", "F12", :ctrl, :shift)
    #
    # @param [String]  win_name    name of the window that will be opened (Pass a blank string for any window)
    # @param [String]  key         key to press (e.g. "a" or "backspace")
    # @param [String]  modifiers   optional modifier(s) to hold down while pressing the key (e.g. :shift, :ctrl, :alt, :meta)
    #
    # @return [int] Window ID of the window shown or 0 if no window is shown
    #
    def open_window_with_key_press(win_name, key, *modifiers)
      wait_start
      key_press(key, *modifiers)
      wait_for_window_shown(win_name)
    end
    
    alias_method :open_dialog_with_key_press, :open_window_with_key_press
    
    
    ######################################################################
    # Executes the action given by action_name, and waits for
    # the window with window name win_name to close
    #
    # @example
    #   $browser.close_window_with_action("New Preferences Dialog", "Cancel")
    #   $browser.close_window_with_action("New Preferences Dialog", "Cancel", "1")
    #
    # @param [String] win_name    name of the window that will be closed (Pass a blank string for any window)
    # @param [String] action_name name of the action to execute to close the window
    # @param [String] param       optional parameter(s) to be supplied with the Opera action.
    #
    # @return [int] Window ID of the window closed or 0 if no window is closed
    #
    def close_window_with_action(win_name, action_name, *params)
      wait_start
      @driver.operaDesktopAction(action_name, params.to_java(:String))
      wait_for_window_close(win_name)
    end
    
    alias_method :close_dialog_with_action, :close_window_with_action
    
    ######################################################################
    # Presses the key, with optional modifiers, and waits for
    # the window with window name win_name to close
    #
    # @example
    #   $browser.close_window_with_key_press("New Preferences Dialog", "Esc")
    #   $browser.close_window_with_key_press("New Preferences Dialog", "w", :ctrl)
    #
    # @param [String]  win_name    name of the window that will be closed (Pass a blank string for any window)
    # @param [String]  key         key to press (e.g. "a" or "backspace")
    # @param [String]  modifiers   optional modifier(s) to hold down while pressing the key (e.g. :shift, :ctrl, :alt, :meta)
    #
    # @return [int] Window ID of the window closed or 0 if no window is closed
    #
    def close_window_with_key_press(win_name, key, *opts)
      wait_start
      key_press(key, *opts)
      wait_for_window_close(win_name)
    end
    
    alias_method :close_dialog_with_key_press, :close_window_with_key_press
    
    ######################################################################
    # Close the dialog with name dialog_name, using the "Cancel" action
    #
    # @param [String] win_name name of the window that will be closed (Pass a blank string for any window)
    #
    # @return [int] Window ID of the dialog closed or 0 if no window is closed
    #
    def close_dialog(dialog_name)
      wait_start
      opera_desktop_action("Cancel")
      wait_for_window_close(dialog_name)
    end
      
    ######################################################################
    # Retrieves an array of all widgets in the window with window 
    # name win_name
    #
    # @example
    #   $browser.widgets(window_name).each do |quick_widget|
    #     if quick_widget.name.length > 0 then
    #       print "   Name:" + quick_widget.name + "\n"
    #     end
    #   end
    #
    # @param win_name [String] name or [int] id of the window to retrieve the list of widgets from,
    #
    # @return [Array] Array of widgets retrieved from the window
    #
    def widgets(win_name)
      @driver.getQuickWidgetList(win_name).map do |java_widget|
        case java_widget.getType
          when QuickWidget::WIDGET_ENUM_MAP[:button]
            QuickButton.new(self,java_widget)
          when QuickWidget::WIDGET_ENUM_MAP[:checkbox]
            QuickCheckbox.new(self,java_widget)
          when QuickWidget::WIDGET_ENUM_MAP[:dialogtab]
            QuickDialogTab.new(self,java_widget)
          when QuickWidget::WIDGET_ENUM_MAP[:dropdown]
            QuickDropdown.new(self,java_widget)
          when QuickWidget::WIDGET_ENUM_MAP[:editfield]
            QuickEditField.new(self,java_widget)
          when QuickWidget::WIDGET_ENUM_MAP[:label]
            QuickLabel.new(self,java_widget)
          when QuickWidget::WIDGET_ENUM_MAP[:radiobutton]
            QuickRadioButton.new(self,java_widget)
          when QuickWidget::WIDGET_ENUM_MAP[:treeview]
            QuickTreeView.new(self,java_widget)
          when QuickWidget::WIDGET_ENUM_MAP[:treeitem]
            QuickTreeItem.new(self,java_widget)
        else
          QuickWidget.new(self,java_widget)
        end
      end.to_a
    end
   
    #@private
    # Retrieves an array of all windows 
    #
    # @return [Array] Array of windows
    #
    def windows
      @driver.getWindowList.map do |java_window|
        QuickWindow.new(self,java_window)
      end.to_a
    end
    
    #@private
    # Retrieve all tabs
    def open_pages
      @driver.getWindowList.map do |java_window|
        if java_window.getName() == "Document Window"
          QuickWindow.new(self,java_window)
        end
      end 
    end
    
    #@private
    def tab_buttons
      tab_buttons = []
      widgets("Browser Window").each do |widget|
        if widget.type == :tabbutton
          tab_buttons << widget
        end
      end
      tab_buttons
    end
    
    #@private
    def print_tab_buttons
      tab_buttons.each do |btn|
        puts btn.to_s
      end
    end
    
    #@private
    def print_tabs
      open_pages.each do |tab| 
        puts tab.to_s
      end
    end
    
    ######################################################################
    # Retrieves the name of a window based on it's id
    #
    # @param [int] win_id Window ID to retrieve the name for
    #
    # @return [String] Name of the window
    #
    def get_window_name(win_id)
      @driver.getWindowName(win_id)
    end
     
    ######################################################################
    # Set preference pref in prefs section prefs_section to value specified
    #
    # @param [String] prefs_section The prefs section the pref belongs to
    # @param [String] pref          The preference to set
    # @param [String] value         The value to set the preference to
    #
    def set_preference(prefs_section, pref, value)
      open_window_with_action("Document Window", "Open url in new page", "opera:config")
      @driver.get("opera:config")
      execute_script("opera.setPreference(\'#{prefs_section}\', \'#{pref}\', #{value});")
      close_window_with_action("Document Window", "Close page", "1")
    end
      
    ######################################################################
    # Get value of preference pref in prefs section prefs_section 
    #
    # @param [String] prefs_section The prefs section the pref belongs to
    # @param [String] pref          The preference to get
    #
    # @return [String] The value of the preference
    #
    def get_preference(prefs_section, pref)
      open_window_with_action("Document Window", "Open url in new page", "opera:config")
      @driver.get("opera:config")
      value = execute_script("opera.getPreference('#{prefs_section}','#{pref}');")
      close_window_with_action("Document Window", "Close page", "1")
      value
    end
    
    def load_page_with_key_press(key, *modifiers)
         wait_start
         key_press(key, *modifiers)
         wait_for_window_loaded("")
    end

    
    ######################################################################
    # Returns true if the test is running on Mac 
    #
    # @return [Boolean] true we the operating system is Mac, otherwise false 
    #
    def mac?
      Config::CONFIG['target_os'] == "darwin"
    end
    
    # @private
    # Special method to access the driver
    attr_reader :driver

private
    # Gets the parent widget name of which there is none here
    def parent_widget
      nil
    end
    
    # Gets the window id to use for the search
    def window_id
      -1
    end
    
    # Launchs an opera action in the correct context
    def opera_desktop_action(name, *param)
      driver.operaDesktopAction(name, param.to_java(:String))
    end
  end
end

