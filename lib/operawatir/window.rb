module WatirHelpers

  def area(type=nil, value=nil)
    c = OperaWatir::Collection.new(self)
    c.add_selector :tag, 'area'
    c.add_selector(type, value) if !type.nil? && !value.nil?
    c
  end

end

class OperaWatir::Window

  include WatirHelpers

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

  # TODO Deprecate
  alias_method :goto, :url=

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

  def eval(js)
    driver.executeScript(js, [])
  end

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


# Opera Specific

  def screenshot(file_name, hashes, time_out)
    driver.saveScreenshot(file_name, time_out, hashes.to_java(:String))
  end

  def visual_hash(time_out=50)
    document.visual_hash timeout
  end


  # TODO Should be private
  def elements
    nil
  end


# Finders

  def find_elements_by_tag_name(name)
    driver.findElementsByTagName(name).to_a.map{|node|
      OperaWatir::Element.new(node)
    }
  end

  def find_elements_by_xpath(xpath)
    driver.findElementsByXpath(xpath).to_a.map{|node|
      OperaWatir::Element.new(node)
    }
  end

private

  def driver
    browser.driver
  end

end