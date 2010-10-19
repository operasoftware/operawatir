module OperaWatir
  class Browser
    include Elements
    include Collections

    attr_reader :driver

    def initialize (executable_location = nil, *arguments)
      if executable_location.nil?
        @driver = OperaDriver.new
        @frame = '_top'
      else
        @driver = OperaDriver.new(executable_location, arguments.to_java(:string))
      end
    end

    # Loads the given URL in the browser.  Waits for the page to get loaded.
    def goto(url = "")
      raise "You need to specify an address" if url.empty?
      @driver.get(url)
    end

    # Stops the loading of the current page.
    def stop
      @driver.stop
    end

    # Cleans up and close the connection to the browser instance.  Will
    # not terminate the browser program.
    def clean_up
      @driver.cleanUp
    end

    # Returns the title of the page.
    def title
      @driver.getTitle
    end

    # Closes the open page/tab.
    def close
      @driver.close
    end

    # Returns the full text of the active page.
    def text
      @driver.getText
    end

    def html
      @driver.getPageSource
    end

    # TODO
    def contains_text?
    end
    alias_method :contains_text, :contains_text?

    # TODO
    def document
    end

    def element_by_xpath(selector)
      @driver.findElementByXPath(selector)
    end

    # Instructs the browser to navigate one page backwards.
    def back
      @driver.navigate.back
    end

    # Instructs the browser to navigate one page forward.
    def forward
      @driver.navigate.forward
    end

    # Refreshes the current page.
    def refresh
      @driver.navigate.refresh
    end

    # Switches focus (active page) to the specified frame.
    #
    # @param [Symbol] method for locating frame, by send the argument
    #   `:name` or `:index`.
    # @param [Integer/String] which frame to switch to.  Depending on what type
    #   of selector you are using, specify the frame's name or its index.
    def frame(how, what)
      case how
      when :name
        @driver.switchTo.frame(what)
      when :index
        @driver.switchTo.frame(what.to_i - 1)  # index starts from 1 in watir
      end
      self
    end

    # Switches focus for active page back to the default frame.
    def switch_to_default
      @driver.switchTo.defaultContent
    end

    # Output a list of frames to the console.
    #
    # @return [String] list of open frames.
    def show_frames
      frames = @driver.listFrames
      puts "There are #{frames.length.to_s} frames"
      frames.each_with_index { |frame,i|
        puts "frame index: #{(i.to_i + 1).to_s} name: #{frame.to_s}"
      }
    end

    # Closes all open pages and quits the browser instance.  The browser
    # instance will be terminated.
    def close_all
      @driver.quit
    end
    alias_method :quit, :close_all

    # Executes the given JavaScript string, and returns the result.
    #
    # @param [String] ECMAscript to be executed.
    # @return [String] result of executed script.
    def execute_script(source)
      @driver.executeScript(source, [].to_java(:string))
    end

    # Send key events to the browser instance.  I.e. “Down” (arrow
    # down), “Space” (space key), “Home”, &c.
    #
    # @param [String] key to be pressed once.
    def key(key)
      @driver.key(key)
    end

    # Enables you to hold down a key, i.e. “Ctrl”, “Alt”, “Shift”, &c.
    # Remember to release the keys afterwards with the key_up method.
    #
    # @param [String] key to be pressed down.
    def key_down(key)
      @driver.keyDown(key)
    end

    # Releases a held down key.
    #
    # @param [String] key to be lifted.
    def key_up(key)
      @driver.keyUp(key)
    end

    # Types given text directly in to the browser.  The text will be
    # inputted to the page depending on where the focus is.
    #
    # @param [String] text to be typed.
    def type(text)
      @driver.type(text)
    end
    alias_method :type_keys, :type

    # Return current URI.
    #
    # @return [String] current URI.
    def url
      @driver.getCurrentUrl
    end

    # Execute specified Opera action.
    #
    # @param [String] name of the Opera action to be performed.
    # @param [String] Optional parameter to be supplied with the Opera action.
    def opera_action(name, *param)
      @driver.operaAction(name, param.to_java(:string))
    end

    # Takes screenshot of the entire page.
    #
    # @param [String] file path you wish to save the screenshot to.
    # @param [Hash] N/A
    # @param [Integer] will attempt to perform the action until the time out is
    #   reached.
    # @return [String] MD5 hash of the full page's screenshot.
    def take_screenshot(file_name,hashes,time_out)
      @driver.saveScreenshot(file_name, time_out, hashes.to_java(:string))
    end

    # Will return the hash of the visual representation of the entire
    # page, which can be used for reference tests.
    #
    # @param [Integer] Will attempt to get the hash of the page until the time
    #   out is rached.
    # @return [String] MD5 hash of the full page's screenshot.
    def get_hash(time_out = 50)
      @driver.findElementByTagName("body").getImageHash
    end

    # Full list of available Opera actions in the Opera build you're using.
    # Note that this list varies from configuration to configuration, and from
    # build to build.  The Opera actions available to devices-type builds will
    # vary greatly from those available to desktop-types.
    #
    # @return [String] list of available Opera actions.
    def opera_action_list
      @driver.getOperaActionList
    end

    # Returns the number of open tabs.
    #
    # @return [Integer] number of open tabs.
    def open_tabs
      @driver.getWindowHandles.size
    end

    # Checks if OperaWatir is connected to any browser instance.  Will
    # return true or false.
    #
    # @return [Boolean] true if OperaWatir is connected to browser instance,
    #   false if otherwise
    def is_connected?
      @driver.isConnected
    end

    # Returns the process identifier (pid), a number used by Unix
    # kernels and Windows operating systems to identify a process.
    #
    # @return [Integer] process identifier of browser instance.
    def pid
      @driver.getPid
    end

    # Returns the version number of OperaDriver.  Please note that the
    # version number of webdriver-opera _is not_ related to the version
    # number for OperaWatir.
    #
    # @return [String] OperaDriver version number.
    def version
      @driver.getOperaDriverVersion
    end
  end
end

