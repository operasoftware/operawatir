include_class org.openqa.selenium.interactions.Actions
#include_class java.util.lang.CharSequence

class OperaWatir::Actions

  attr_accessor :browser
  attr_accessor :driver
  attr_accessor :actions

  def initialize(browser)
    self.browser, self.driver = browser, browser.driver
    self.actions = Java::OrgOpenqaSeleniumInteractions::Actions.new(@driver)

    @sym_key_map = {}
  end

  # If only one argument is given then it is the key, and so we call the
  # method that accepts only the key
  def key_down(element, key = nil)
    if not key
      @actions.keyDown(sym_to_key(element))
    else
      @actions.keyDown(element.node, sym_to_key(key))
    end
    self
  end

  # If only one argument is given then it is the key, and so we call the
  # method that accepts only the key
  def key_up(element, key = nil)
    if not key
      @actions.keyUp(sym_to_key(element))
    else
      @actions.keyUp(element.node, sym_to_key(key))
    end
    self
  end

  # If only one argument is given then it is the key, and so we call the
  # method that accepts only the key
  def send_keys(element, keys_to_send = nil)
    if not keys_to_send
      @actions.sendKeys(element)
    else
      @actions.sendKeys(element.node, keys_to_send)
    end
    self
  end

  def click_and_hold(element)
    @actions.clickAndHold(element.node)
    self
  end

  def release(element)
    @actions.release(element.node)
    self
  end

  def click(element = nil)
    element ? @actions.click(element.node) : @actions.click()
    self
  end

  def double_click(element = nil)
    element ? @actions.double_click(element.node) : @actions.click()
    self
  end

  def move_to_element(element, x_offset = 0, y_offset = 0)
    @actions.moveToElement(element.node, x_offset, y_offset)
    self
  end

  def move_by_offset(x_offset, y_offset)
    @actions.moveByOffset(x_offset, y_offset)
    self
  end

  def context_click(element)
    @actions.contextClick(element.node)
    self
  end

  def drag_and_drop(source, target)
    @actions.dragAndDrop(source, target)
    self
  end

  def drag_and_drop_by(source, x_offset, y_offset)
    @actions.dragAndDrop(source, x_offset, y_offset)
    self
  end

  def perform()
    @actions.perform()
  end

private

  def sym_to_key(sym)
    if @sym_key_map.empty?
      Java::OrgOpenqaSelenium::Keys.values().each do |k|
        @sym_key_map[k.name().downcase.to_sym] = k
      end
    end

    @sym_key_map[sym]
  end

end
