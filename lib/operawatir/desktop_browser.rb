module OperaWatir
  class DesktopBrowser < Browser
    include DesktopContainer
    include DesktopCommon
    
    #@private
    LoadActions = ["Open url in new page", "Open url in current page", "Open url in background page",
      "Open url in new window"]
    
    # @private
    def initialize (executable_location = nil, *arguments)
      if executable_location.nil?
        @driver = OperaDesktopDriver.new
      else
        @driver = OperaDesktopDriver.new(executable_location, arguments.to_java(:String))
      end
    end

    # @private
    # Hack overload to allow for timing of the OnLoaded event that can cause 
    # dialogs to autoclose in Dialog.cpp when then OnUrlChanged is fired 
    # after a dialog is opened
    def goto(url = "")
      super
      sleep(1)
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
    #                             the action cannot be a load action, see LoadActions
    # @param [String] param       optional parameter(s) to be supplied with the Opera action.
    #
    # @return [int] Window ID of the window shown or 0 if no window is shown
    def open_window_with_action(win_name, action_name, *params)
      if LoadActions.include?(action_name) then
        raise(DesktopExceptions::UnsupportedActionException, "Action #{action_name} not supported")
      end
      
      wait_start
      @driver.operaDesktopAction(action_name, params.to_java(:String))
      wait_for_window_shown(win_name)
    end
    
    alias_method :open_dialog_with_action, :open_window_with_action
    
    ######################################################################
    # Executes the action given by action_name, and waits for
    # the window with window name win_name to be loaded
    #
    # @example
    #   $browser.load_window_with_action("Document Window", "Open url in new page")
    #
    # @param [String] win_name    name of the window that will be opened (Pass a blank string for any window)
    # @param [String] action_name name of the action to execute to open the window
    #                             the action has to be one of those in LoadActions
    # @param [String] param       optional parameter(s) to be supplied with the Opera action.
    #
    # @return [int] Window ID of the window shown or 0 if no window is shown
    def load_window_with_action(win_name, action_name, *params)
      if LoadActions.include?(action_name) 
        wait_start
        @driver.operaDesktopAction(action_name, params.to_java(:String))
        wait_for_window_loaded(win_name)
      else
        raise(DesktopExceptions::UnsupportedActionException, "Action #{action_name} not supported")
      end
    end

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
    # @param [Symbol]  modifiers   optional modifier(s) to hold down while pressing the key (e.g. :shift, :ctrl, :alt, :meta)
    #
    # @return [int] Window ID of the window shown or 0 if no window is shown
    #
    def open_window_with_key_press(win_name, key, *modifiers)
      wait_start
      key_press_direct(key, *modifiers)
      wait_for_window_shown(win_name)
    end
    
    alias_method :open_dialog_with_key_press, :open_window_with_key_press
    
    ######################################################################
    # Clicks the key and modifiers and waits for a new tab to be activated
    #
    # @param [String]  key         key to press (e.g. "a" or "backspace")
    # @param [Symbol]  modifiers   optional modifier(s) to hold down while pressing 
    #                                the key (e.g. :shift, :ctrl, :alt, :meta)
    #
    # @return [int] Window ID of the document window (tab) that is activated, or 0 if no tab
    #   is being activated
    #
    def activate_tab_with_key_press(key, *modifiers)
      wait_start
      key_press_direct(key, *modifiers)
      wait_for_window_activated("Document Window")
    end
    
    ######################################################################
    # Opens a new tab and loads the url entered, then waits for
    # a dialog to be shown based on the url entered
    #
    # @param [String] dialog_name name of the dialog that will be closed 
    #                       (Pass a blank string for any window)
    # @param [String] url to load 
    #
    # @return [int] Window ID of the dialog closed or 0 if no window is closed
    #
    def open_dialog_with_url(dialog_name, url)
      wait_start
      @driver.operaDesktopAction("Open url in new page", [url].to_java(:String))
      # The loading of the page will happen first then the dialog will be shown
      wait_for_window_shown(dialog_name)
    end
    
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
    # @param [Symbol]  modifiers   optional modifier(s) to hold down while pressing the key (e.g. :shift, :ctrl, :alt, :meta)
    #
    # @return [int] Window ID of the window closed or 0 if no window is closed
    #
    def close_window_with_key_press(win_name, key, *opts)
      wait_start
      key_press_direct(key, *opts)
      wait_for_window_close(win_name)
    end
    
    alias_method :close_dialog_with_key_press, :close_window_with_key_press
    
    ######################################################################
    # Close the dialog with name dialog_name, using the "Cancel" action
    #
    # @param [String] dialog_name name of the dialog that will be closed 
    #                 (Pass a blank string for any window)
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
    #       puts quick_widget.to_s
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
   
    ####################################################
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
      windows.select { |win| win.name == "Document Window" }
    end
    
    #@private
    # Not needed as quick_tabs is def. below
    #def tab_buttons
    #  widgets("Browser Window").select { | w | w.type == :tabbutton }
    #end
    
#=begin
    # Return collection for each widget type
    # example $browser.quick_buttons
    #         $browser.quick_treeitems
    #         ....
    #    
    WIDGET_ENUM_MAP.keys.each do |widget_type|
      my_type = "quick_" << widget_type.to_s
      type = my_type
      if my_type == "quick_search" || my_type == "quick_checkbox"
        my_type << "es"
      else
        my_type << "s"
      end
      define_method(my_type.to_sym) do |win|
        widgets(win).select { |w| w.type == widget_type}
      end
    end
#=end
    
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
      load_window_with_action("Document Window", "Open url in new page", "opera:config")
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
      load_window_with_action("Document Window", "Open url in new page", "opera:config")
      @driver.get("opera:config")
      value = execute_script("opera.getPreference('#{prefs_section}','#{pref}');")
      close_window_with_action("Document Window", "Close page", "1")
      value
    end
    
    ######################################################################
    # Presses the key, with optional modifiers, and waits for loaded event
    #
    # @example
    #   $browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").\n
    #                          type_text(text_to_type).should == text_to_type
    #   $browser.load_page_with_key_press("Enter").should > 0
    #
    # @param [String]  key         key to press (e.g. "a" or "backspace")
    # @param [Symbol]  modifiers   optional modifier(s) to hold down while pressing the key (e.g. :shift, :ctrl, :alt, :meta)
    #
    # @return [int] Window ID of the window loaded or 0 if no window is loaded
    #
    def load_page_with_key_press(key, *modifiers)
         wait_start
         key_press_direct(key, *modifiers)
         wait_for_window_loaded("")
    end

    ######################################################################
    # Returns the full path to the Opera executable 
    #
    # @return [String] Full path to the opera executable 
    #
    def get_opera_path
      @driver.getOperaPath()
    end

    ######################################################################
    # Returns an array of full paths to each folder that holds 
    # Opera preferences
    #
    # @return [Array] Array of full paths to Opera preference folders  
    #
    def get_opera_preferences_paths
      @driver.getPreferencesPaths().to_a
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
    
    ######################################################################
    # Clear all private data (as in Delete Private data Dialog) 
    #
    # @return [int] 0 if operation failed 
    #
    def clear_all_private_data
      win_id = open_dialog_with_action("Clear Private Data Dialog", "Delete private data")
      return 0 if win_id == 0
      
      #Ensure is Expanded
      if quick_button(:name, "Destails_expand").value == 0
        quick_button(:name, "Destails_expand").toggle_with_click
      end
           
      quick_checkboxes("Clear Private Data Dialog").each do |box|
        #puts "checkbox #{box.name}"
        box.toggle_with_click unless box.checked?
=begin
        if box.checked? == false
          #TODO: This should be fixed. the iterator should return real widget objects
          quick_checkbox(:name, box.name).toggle_with_click
        end
=end        
      end
      
      #Delete all
      win_id = quick_button(:name, "button_OK").close_dialog_with_click("Clear Private Data Dialog")
    end
    
    ######################################################################
    # Clear typed and visited history
    #
    def clear_history
      #TODO: Use Delete Private Data Dialog?
      opera_desktop_action("Clear visited history")
      opera_desktop_action("Clear typed in history")
    end
    
    ######################################################################
    #  
    #
    #  
    #
    def clear_cache
      #TODO: Use Delete Private Data Dialog?
      opera_desktop_action("Clear disk cache")
    end
    
    ######################################################################
    # 
    #
    #  
    #
    def close_all_tabs
=begin      
      if open_dialog_with_action("Close All Confirm Dialog", "Close all") > 0
         quick_button(:name, "button_OK).close_dialog_with_click("Close All Confirm Dialog")
      end
=end
=begin
      (quick_tabbuttons("Browser Window").length - 1).times do
        quick_tab(:pos, 1).close_window_with_click("Document Window")
      end
=end      
      quick_tabbuttons("Browser Window").each do |btn|
        btn.close_window_with_click("Document Window") unless btn.position == 0
      end
    end
    
    #####################################################################
    # 
    #
    #  
    #
    def close_all_dialogs
      #TODO:
       
    end
    
    
=begin  
  TODO:  
  delete cookies
  reset main window   
=end    
    

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

