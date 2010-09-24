module OperaWatir
 class DesktopBrowser < Browser
    include DesktopContainer
    include DesktopEnums
    
    def initialize (executable_location = nil, *arguments)
      if executable_location.nil?
        @driver = OperaDesktopDriver.new
      else
        @driver = OperaDesktopDriver.new(executable_location, arguments.to_java(:String))
      end
    end

    # Execute specified Opera action in the correct input context
    #
    # Arguments:
    # name::   name of the Opera action to be performed.
    # param::  (Optional)  Optional parameter to be supplied with the Opera action.
    #
    def opera_desktop_action(name, *param)
      @driver.operaDesktopAction(name, param.to_java(:String))
    end


    # Executes the action given by paramter action_name, and waits for
    # the window with window name win_name to be shown
    #
    # Arguments:
    # win_name::  name of the window to wait to be shown (Pass a blank string for any window)
    # action_name:: name of the action to execute
    # param::  (Optional)  Optional parameter to be supplied with the Opera action.
    #
    def open_window_with_action(win_name, action_name, *param)
      wait_start
      @driver.operaDesktopAction(action_name, param.to_java(:String))
      wait_for_window_shown(win_name)
    end

   # Executes the action given by paramter action_name, and waits for
   # the window with window name win_name to close
   #
   # Arguments:
   # win_name::  name of the window to wait to closed (Pass a blank string for any window)
   # action_name:: name of the action to execute
   # param::  (Optional)  Optional parameter to be supplied with the Opera action.
   #
   def close_window_with_action(win_name, action_name, *param)
     wait_start
     @driver.operaDesktopAction(action_name, param.to_java(:String))
     wait_for_window_close(win_name)
   end

   # Executes the action given by paramter action_name, and waits for
   # the dialog with window name win_name to be shown
   #
   # Arguments:
   # win_name::  name of the window to wait to be shown (Pass a blank string for any window)
   # action_name:: name of the action to execute
   # param::  (Optional)  Optional parameter to be supplied with the Opera action.
   #
   def open_dialog_with_action(win_name, action_name, *param)
     open_window_with_action(win_name, action_name, *param)
   end

    
    # Close the dialog with window name win_name
    # Returns when the dialog is closed
    #
    # Arguments:
    # win_name:: name of the window to wait to be closed  (Pass a blank string for any window)
    #
    def close_dialog(win_name)
      wait_start
      opera_desktop_action("Cancel")
      wait_for_window_close(win_name)
    end
    
    # Retrieves an iterator over all widgets in the window with window name win_name
    #
    # Arguments:
    # win_name:: name of the window
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
        else
          QuickWidget.new(self,java_widget)
        end
      end.to_a
    end
    
    # Retrieves an iterator over all open windows
    #
    # Arguments:
    #
    #def windows
    #  @driver.getWindowList.map do |window|
    #    QuickWindow.new(self,window)
    #  end.to_a
    #end
   
   # Retrieves the name of a window based on it's id
   #
   # Arguments:
   # win_id:    id of the window
   #
   def get_window_name(win_id)
     @driver.getWindowName(win_id)
   end
   
    # 
    #  
    def key_press(key, *opts)
      puts "key_press #{key}" 
      #KEYMODIFIER_ENUM_MAP.each { |k, v| puts "#{k},#{v}"}
      list = Java::JavaUtil::ArrayList.new
      opts.each { |mod| list << KEYMODIFIER_ENUM_MAP[mod] }
      @driver.keyPress(key, list)
    end

    def type(text)
      text.each_char { | t | key_press t }
    end
    
     # Set preference pref in prefs section prefs_section to value specified
    #
    # Arguments:
    # prefs_section:: The prefs section the pref belongs to
    # pref:: The preference to set
    # value:: The value to set the preference to
    #
    def set_preference(prefs_section, pref, value)
      open_window_with_action("Document Window", "Open url in new page", "opera:config")
      @driver.get("opera:config")
      execute_script("opera.setPreference(\'#{prefs_section}\', \'#{pref}\', #{value});")
      close_window_with_action("Document Window", "Close page", "1")
    end
    
   # Get value of preference pref in prefs section prefs_section 
   #
   # Arguments:
   # prefs_section:: The prefs section the pref belongs to
   # pref:: The preference to get
    def get_preference(prefs_section, pref)
      open_window_with_action("Document Window", "Open url in new page", "opera:config")
      @driver.get("opera:config")
      value = execute_script("opera.getPreference('#{prefs_section}','#{pref}');")
      close_window_with_action("Document Window", "Close page", "1")
      value
    end

    
   private
       
   # 
   #
   def wait_start
     @driver.waitStart()
   end

   # Waits for the window specified by parameter win_name to be shown
   # If no parameter is specified, waits for any window show event
   #
   # Arguments:
   # win_name::  name of the window
   #
   def wait_for_window_shown(win_name = "")
     @driver.waitForWindowShown(win_name)
   end

   # Waits for window updated event on the window given by win_name
   # If no parameter is specified, waits for any window updated event
   #
   # Arguments:
   # win_name::  name of the window
   #
   def wait_for_window_updated(win_name = "")
     @driver.waitForWindowUpdated(win_name)
   end

   # Waits for window activated event on the window given by win_name
   # If no parameter is specified, waits for any window activated event
   #
   # Arguments:
   # win_name::  name of the window
   #
   def wait_for_window_activated(win_name = "")
     @driver.waitForWindowActivated(win_name)
   end

   # Waits for window closed event on the window given by win_name
   # If no parameter is specified, waits for any window closed event
   #
   # Arguments:
   # win_name::  name of the window
   #
   def wait_for_window_close(win_name = "")
     @driver.waitForWindowClose(win_name)
   end
  end
end

