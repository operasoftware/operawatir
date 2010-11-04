module OperaWatir
  # @private
  # This module is to share functions in the driver between modules so 
  # should not be in the documentation
  module DesktopCommon
    include DesktopEnums

private

    def key_press(key, *opts)
      #puts "key_press #{key}, opts #{opts}" 
      #KEYMODIFIER_ENUM_MAP.each { |k, v| puts "#{k},#{v}"}
      list = Java::JavaUtil::ArrayList.new
      opts.each { |mod| list << KEYMODIFIER_ENUM_MAP[mod] }
      driver.keyPress(key, list)
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

  end
end