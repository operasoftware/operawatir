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
    # Input:
    # how::  Supply method for locating frame, by send the argument <tt>:name</tt> or <tt>:index</tt>.
    # what::  Specify which frame.  Depending on what type of selector you are using, specify the frame's name or its index.
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
    def execute_script(source)
      @driver.executeScript(source, [].to_java(:string))
    end

    # Send key events to the browser instance.  I.e. “Down” (arrow
    # down), “Space” (space key), “Home”, &c.
    def key(key)
      @driver.key(key)
    end

    # Enables you to hold down a key, i.e. “Ctrl”, “Alt”, “Shift”, &c.
    # Remember to release the keys afterwards with the key_up method.
    def key_down(key)
      @driver.keyDown(key)
    end

    # Releases a held down key.
    def key_up(key)
      @driver.keyUp(key)
    end

    # Types given text directly in to the browser.  The text will be
    # inputted to the page depending on where the focus is.
    def type(text)
      @driver.type(text)
    end
    alias_method :type_keys, :type

    # Return current URI.
    def url
      @driver.getCurrentUrl
    end

    # Execute specified Opera action.
    #
    # Arguments:
    # name::   name of the Opera action to be performed.
    # param::  (Optional.)  Optional parameter to be supplied with the Opera action.
    def opera_action(name, *param)
      @driver.operaAction(name, param.to_java(:string))
    end

    # Takes screenshot of the entire page.
    #
    # Arguments:
    # file_name::  the absolute file path you wish to save the screenshot to.
    # time_out::   will attempt to perform the action until the time out is reached.
    def take_screenshot(file_name,hashes,time_out)
      @driver.saveScreenshot(file_name, time_out, hashes.to_java(:string))
    end

    # Will return the hash of the visual representation of the entire
    # page, which can be used for reference tests.
    #
    # Arguments:
    # time_out::  Will attempt to get the hash of the page until the time out is reached.
    def get_hash(time_out = 50)
      @driver.findElementByTagName("body").getImageHash
    end

    # Returns a full list of available Opera actions in the Opera build
    # you're using.  Note that this list varies from configuration to
    # configuration, and from build to build.  The Opera actions
    # available to devices-type builds will vary greatly from those
    # available to desktop-types.
    def opera_action_list
      @driver.getOperaActionList
    end

    # Returns the number of open pages/tabs.
    def open_tabs
      @driver.getWindowHandles.size
    end

    # Will return the garbage collection.
    def gc
      @driver.gc
    end

    # Checks if OperaWatir is connected to any browser instance.  Will
    # return true or false.
    def is_connected?
      @driver.isConnected
    end

    # Returns the Process identifier (pid), a number used by Unix
    # kernels and Windows operating systems to identify a process.
    def pid
      @driver.getPid
    end

    # Returns the version number of OperaDriver.  Please note that the
    # version number of webdriver-opera _is not_ related to the version
    # number for OperaWatir.
    def version
      @driver.getOperaDriverVersion
    end
  end
end
