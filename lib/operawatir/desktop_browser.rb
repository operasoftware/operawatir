module OperaWatir
 class DesktopBrowser < Browser
    include DesktopContainer

    def initialize (executable_location = nil, *arguments)
      if executable_location.nil?
        @driver = OperaDesktopDriver.new
        @frame = '_top'
      else
        @driver = OperaDesktopDriver.new(executable_location, arguments.to_java(:String))
      end
    end

    # Execute specified Opera action in the correct input context
    #
    # Arguments:
    # name::   name of the Opera action to be performed.
    # param::  (Optional.)  Optional parameter to be supplied with the Opera action.
    def opera_desktop_action(name, *param)
      @driver.operaDesktopAction(name, param.to_java(:String))
    end

    def wait_start
      @driver.waitStart()
    end

    def wait_for_window_updated(win_name = "")
      @driver.waitForWindowUpdated(win_name)
    end

    def wait_for_window_activated(win_name = "")
      @driver.waitForWindowActivated(win_name)
    end

    def wait_for_window_close(win_name = "")
      @driver.waitForWindowClose(win_name)
    end

    def close_dialog(win_name = "")
      wait_start
      opera_desktop_action("Cancel")
      wait_for_window_close(win_name)
    end
  end
end

