class OperaWatir::Window
  include Deprecated

  attr_accessor :browser

  # Creates a new window in the browser.  Note that Opera does not
  # differentiate between windows and tabs.  To directly create a
  # _Window_ object, pass in the _Browser_.
  #
  # @example
  #   window = browser.url = 'http://example.org/'
  #   => OperaWatir::Window
  #
  # @param  [Object] browser The _Browser_ object.
  # @return [Object]         A new _Window_ object.
  def initialize(browser)
    self.browser = browser
  end


  # Navigation

  # Navigates back one step in the browser's history.
  def back
    driver.navigate.back
  end

  # Navigates forward one step in the browser's history.
  def forward
    driver.navigate.forward
  end

  # Stops the currently loading page.
  def stop
    driver.stop
  end

  # Closes the currently open window.
  def close
    driver.close  # FIXME?
  end

  # Refreshes the currently loaded page.
  def refresh
    driver.navigate.refresh
  end

  # Gets the title of the document.
  #
  # @return [String] The title of the current document.
  def title
    driver.getTitle
  end

  #
  # Gets the URL of the document.
  #
  # @return [String] The URL of the current document.
  #

  def url
    driver.getCurrentUrl
  end

  #
  # Navigates to a new URL.
  #

  def url=(url)
    driver.navigate.to(url)
  end

  alias_method :goto, :url=  # deprecate?

  #
  # Refreshes the page.
  #

  def refresh
    driver.navigate.refresh
  end

  # Retrieves the text without the DOM or source code from the
  # currently loaded document.
  #
  # @return [String] The text of the document.
  def text
    document.text
  end

  # Retrieves the HTML/source code of the currently loaded document.
  #
  # @return [String] The page source code.
  def html
    driver.getPageSource
  end

  # Checks if the window is still open.  True if the window is still
  # present, false otherwise.
  #
  # @return [Boolean] Whether the window is open or not.
  def exists?
    # TODO: Expose window querying from driver
    url != ''
  end

  # Executes the given JavaScript on the current window.
  #
  # @param  [String] js The script to be executed.
  # @return [String]    Optionally returns the JS result.
  def execute_script(js)
    object = driver.executeScript(js, [].to_java(:string))
  end

  alias_method :eval_js, :execute_script
  deprecated :eval_js, 'window.execute_script'


  # Opera-specific

  #
  # Creates a Screenshot interface or saves screenshot to specified
  # location if a file path is given.
  #
  # @param [String] file_name The absolute path to the location where 
  #                           you want the screenshot saved.
  #
  # @return [Object]          A Screenshot object.
  # @return [String]          Filename to the saved file.
  #

  def screenshot(filename=nil)
    # TODO: This should call document.screenshot instead, but that
    # requires a generic ScreenShotReply interface in OperaDriver.
    filename.nil? ? OperaWatir::Screenshot.new(self) : OperaWatir::Screenshot.new(self).save(filename)
  end

  #
  # Returns a visual hash sum of the document.  It takes a screenshot of
  # the page and generates an MD5 hash sum of it.
  #
  # @return [String]          A hash sum.
  #

  def visual_hash
    document.visual_hash
  end

  # Raw finders

  OperaWatir::Selector::BASE_TYPES.each do |type|
    define_method("find_by_#{type}") do |name|
      OperaWatir::Collection.new(self).tap do |c|
        c.selector.send(type, name.to_s)
      end
    end
  end

  alias_method :find_by_class, :find_by_class_name
  alias_method :find_by_tag, :find_by_tag_name

  #
  # Finds the root element of the document.  For HTML document, this is
  # the element with the tagName “HTML”.
  #
  # @return [Element] The root element of the document.
  #

  def document
    find_by_css(':root')
  end

  #
  # Finds all elements in document.
  #
  # @return [Collection] A collection of elements.
  #

  def elements
    find_by_tag('*')
  end

  def method_missing(tag, *args)
    OperaWatir::Collection.new(self).tap do |c|
      c.selector.tag_name tag
      c.add_selector_from_arguments args
    end
  end


private

  def find_elements_by_id(value)
    driver.findElementsById(value).to_a.map do |node|
      OperaWatir::Element.new(node)
    end
  end

  def find_elements_by_class_name(value)
    driver.findElementsByClassName(value).to_a.map do |node|
      OperaWatir::Element.new(node)
    end
  end

  def find_elements_by_tag_name(value)
    driver.findElementsByTagName(value).to_a.map do |node|
      OperaWatir::Element.new(node)
    end
  end

  def find_elements_by_css(value)
    driver.findElementsByCssSelector(value).to_a.map do |node|
      OperaWatir::Element.new(node)
    end
  end

  def find_elements_by_xpath(value)
    driver.findElementsByXPath(value).to_a.map do |node|
      OperaWatir::Element.new(node)
    end
  end

  def find_elements_by_name(value)
    driver.findElementsByName(value).to_a.map do |node|
      OperaWatir::Element.new(node)
    end
  end

  def driver
    browser.driver
  end

end
