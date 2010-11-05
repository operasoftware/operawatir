class OperaWatir::Window

  attr_accessor :browser

  def initialize(browser)
    self.browser = browser
  end
  

  # Navigation

  def back
    driver.navigate.back
  end

  def forward
    driver.navigate.forward
  end

  def stop
    driver.stop
  end

  def close
    driver.close
  end

  def refresh
    driver.navigate.refresh
  end

  def title
    driver.getTitle
  end

  def url
    driver.getCurrentUrl
  end

  def url=(url)
    driver.get(url)
  end
  alias_method :goto, :url=  # deprecate?

  def text
    driver.getText
  end

  def html
    driver.getPageSource
  end

  # TODO HACK
  def exist?
    url != ''
  end

  def document
  end

  def eval_js(js)
    driver.executeScript(js, [])
  end
  alias_method :execute_script, :eval_js


  # Keyboard

  def key(key)
    driver.key(key)
  end

  def key_down(key)
    driver.keyDown(key)
  end

  def key_up(key)
    driver.keyUp(key)
  end

  def type(text)
    driver.type(text)
  end


  # Opera-specific

  def screenshot(file_name, hashes=[], time_out=2)
    driver.saveScreenshot(file_name, time_out, hashes.to_java(:string))
  end

  def visual_hash(time_out=50)
    document.visual_hash timeout
  end
  alias_method :get_hash, :visual_hash

  
  # Finders
  
  def find_by_id(id)
    OperaWatir::Collection.new self, driver.findElementsById(id).to_a.map do |node|
      OperaWatir::Element.new(node)
    end
  end
  
  def find_by_class(klass)
    OperaWatir::Collection.new self, driver.findElementsByClassName(klass).to_a.map do |node|
      OperaWatir::Element.new(node)
    end
  end
  
  def find_by_tag(tag)
    OperaWatir::Collection.new self, driver.findElementsByTagName(tag).to_a.map do |node|
      OperaWatir::Element.new(node)
    end
  end
  
  def find_by_css(css)
    OperaWatir::Collection.new self, driver.findElementsByCssSelector(css).to_a.map do |node|
      OperaWatir::Element.new(node)
    end
  end
  
  def find_by_xpath(xpath)
    OperaWatir::Collection.new self, driver.findElementsByXpath(xpath).to_a.map do |node|
      OperaWatir::Element.new(node)
    end
  end
  
  def element(*attribs, &blk)
    method_missing('*', *attribs, &blk)
  end
  alias_method :elements, :element
    
  def method_missing(tag, *attribs, &blk)
    c = OperaWatir::Collection.new(self)
    c.selector.find_by_tag tag
    c.selector.find_by_attribs(*attribs) unless attribs.empty?
    c
  end

private

  # @private
  # @return [Object] the driver instance.
  def driver
    browser.driver
  end

end
