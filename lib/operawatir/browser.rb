module OperaWatir
  class Browser
    include Elements
    include Collections

    attr_reader :driver
    alias_method :element, :driver

    # Starts a new browser instance and navigates to a page
    #
    # @param [String] url the URL the browser should open at
    # @return [Browser] new browser instance
    def self.start(url, *args)
      b = new(*args)
      b.goto url
      b
    end

    # Initializes a new browser instance
    #
    # @param [String] executable_location the path to the Opera binary
    # @param [String...] arguments  any extra arguments to be passed to the
    #   binary
    def initialize(executable_location = nil, *arguments)
      if executable_location.nil?
        @driver = OperaDriver.new
        @frame = '_top'
      else
        @driver = OperaDriver.new(executable_location, arguments.to_java(:String))
      end
    end

    # Loads the given URL in the browser. Waits for the page to load
    # @param [String] url The address to go to
    def goto(url = "")
      raise 'You need to specify an address' if url.empty?
      driver.get(url)
    end

    # Stops the loading of the current page.
    def stop
      driver.stop
    end

    # Cleans up and close the connection to the browser instance.  Will
    # not terminate the browser program.
    # @private
    def clean_up
      driver.cleanUp
    end

    # @return [String] title of the page
    def title
      driver.getTitle
    end

    # Closes the open page/tab.
    def close
      driver.close
    end

    # @return [String] The full text of the active page.
    def text
      driver.getText
    end

    # @return [String] the HTML source of the current page
    # @todo Doesn't return doctype
    def html
      driver.getPageSource
    end

    # @return [Boolean] Wether the brower exists or not
    def exist?
      url != ''
    end

    # @todo
    def contains_text?(a)
    end

    alias_method :contains_text, :contains_text?

    # @todo
    def document
    end

    # @private
    def element_by_xpath(selector)
      driver.findElementByXPath(selector)
    end

    # Instructs the browser to navigate one page backwards.
    def back
      driver.navigate.back
    end

    # Instructs the browser to navigate one page forward.
    def forward
      driver.navigate.forward
    end

    # Refreshes the current page.
    def refresh
      driver.navigate.refresh
    end

    # Switches focus (active page) to the specified frame.
    #
    # @param [Symbol] how How to locate the frame, either by :name or :index
    # @param [String, Integer] what What to locate the frame by
    def frame(how, what)
      case how
      when :name
        driver.switchTo.frame(what)
      when :index
        driver.switchTo.frame(what.to_i - 1) #index starts from 1 in watir
      end
      self
    end

    # Switches focus for active page back to the default frame.
    def switch_to_default
      driver.switchTo.defaultContent
    end

    # @return [Array] List of open frames
    def frames
      driver.listFrames
    end

    # Output a list of frames to the console.
    # @private
    def show_frames
      puts "There are #{frames.length.to_s} frames"
      frames.each_with_index { |frame,i|
        puts "frame index:#{(i.to_i+1).to_s} name:#{frame.to_s}"
      }
    end

    # Closes all open pages and quits the browser instance.  The browser
    # instance will be terminated.
    def close_all
      driver.quit
    end
    alias_method :quit, :close_all

    # Executes the given JavaScript string, and returns the result.
    #
    # @param [String] source Javascript source
    # @return [String] result
    def execute_script(source)
      driver.executeScript(source, [].to_java(:String))
    end

    # Send key events to the browser instance.  I.e. “Down” (arrow
    # down), “Space” (space key), “Home”, &c.
    #
    # @see #key_down
    # @see #key_up
    def key(key)
      driver.key(key)
    end

    # Enables you to hold down a key, i.e. “Ctrl”, “Alt”, “Shift”, &c.
    #
    # @param [String] key Key to press. Either a character or "Ctrl", "Alt", "Shift" etc.
    # @see #key_up
    # @note Remember to release the keys afterwards with #key_up.
    def key_down(key)
      driver.keyDown(key)
    end

    # Releases a held down key.
    #
    # @param [String] key Key to release. Either a character or "Ctrl", "Alt", "Shift" etc.
    # @see #key_down
    def key_up(key)
      driver.keyUp(key)
    end

    # Types given text directly in to the browser. The text will be
    # inputted to the page depending on where the focus is.
    #
    # @param [String] text sequence of keys to type
    def type(text)
      driver.type(text)
    end

    # @return [String] the current URI.
    def url
      driver.getCurrentUrl
    end

    # Execute specified Opera action.
    #
    # @param [Symbol] name the name of the action
    # @param [String...] params any additional parameters for the action
    def opera_action(name, *params)
      driver.operaAction(name, params.to_java(:String))
    end

    # Takes screenshot of the entire page.
    #
    # @param [String] file_name The absolute path the the output file
    # @param [Integer] time_out Will attempt to take screenshot until
    #   +timeout+ is reached
    # @param [String] hashes cache hash
    def take_screenshot(file_name,hashes,time_out)
      driver.saveScreenshot(file_name, time_out, hashes.to_java(:String))
    end

    # Hashes the visual representation of the page. Can be used for reference
    #   tests.
    #
    # @param [Integer=50] time_out Will wait +time_out+ seconds before
    #   aborting hash.
    # @todo Implement timeout
    def get_hash(time_out = 50)
      driver.findElementByTagName('body').getImageHash
    end

    # Returns a full list of available Opera actions in the Opera build
    # you're using.  Note that this list varies from configuration to
    # configuration, and from build to build.  The Opera actions
    # available to devices-type builds will vary greatly from those
    # available to desktop-types.
    # @private
    def opera_action_list
      driver.getOperaActionList
    end

    # @return [Integer] The number of open pages/tabs.
    def open_tabs
      driver.getWindowHandles.size
    end

    # @private
    def gc
      driver.gc
    end

    # @private
    # Checks if OperaWatir is connected to any browser instance.
    # @return [Boolean]
    def is_connected?
      driver.isConnected
    end

    # @private
    # @return [Integer] the Process identifier (pid), a number used by Unix
    #   kernels and Windows operating systems to identify a process.
    def pid
      driver.getPid
    end

    # @private
    # @return [String] the version number of OperaDriver.
    # @note   The version number of webdriver-opera _is not_ related to the
    #         version number for OperaWatir.
    def version
      driver.getOperaDriverVersion
    end

  end
end

