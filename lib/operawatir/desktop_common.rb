module OperaWatir
  # @private
  # This module is to share functions in the driver between modules so 
  # should not be in the documentation
  module DesktopCommon
    include DesktopEnums

private

    def key_press_direct(key, *opts)
      list = Java::JavaUtil::ArrayList.new
      opts.each { |mod| list << KEYMODIFIER_ENUM_MAP[mod] }
      driver.keyPress(key, list)
    end
    
    def key_down(key, *opts)
      puts "keydown"
      list = Java::JavaUtil::ArrayList.new
      opts.each { |mod| list << KEYMODIFIER_ENUM_MAP[mod] }
      driver.keyDown(key, list)
    end
    
    def key_up(key, *opts)
      puts "keyup"
      list = Java::JavaUtil::ArrayList.new
      opts.each { |mod| list << KEYMODIFIER_ENUM_MAP[mod] }
      driver.keyUp(key, list)
    end
    
   # Private wait functions
    #
    def wait_start
      driver.waitStart()
    end
 
    def wait_for_window_shown(win_name = "")
      driver.waitForWindowShown(win_name)
    end
 
    def wait_for_window_updated(win_name = "")
      driver.waitForWindowUpdated(win_name)
    end
 
    def wait_for_window_activated(win_name = "")
      driver.waitForWindowActivated(win_name)
    end
 
    def wait_for_window_close(win_name = "")
      driver.waitForWindowClose(win_name)
    end
    
    def wait_for_window_loaded(win_name = "")
      win_id = driver.waitForWindowLoaded(win_name)
      # Hack to allow for Javascript focus events and the like
      sleep(0.1)
      win_id
    end
    
    def wait_for_widget_enabled
      max_timeout = 1.5
      curr_timeout = 0.0
      step = 0.1
      
      while curr_timeout < max_timeout  
        if element(true).isEnabled == true
          break
        end

        sleep(step)
        curr_timeout += step
      end
      
      # Check we didn't exceed the timeout
      if curr_timeout >= max_timeout
        return false
      end
      
      # Return true
      true
    end
  end
end
