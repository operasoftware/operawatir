class OperaWatir::Element
  extend Forwardable

  def initialize(node)
    self.node = node
  end


  # Attributes

  def attr(name)
    node.getAttribute(name.to_s)
  end

  # TODO Move to Webdriver
  # Relies on getAttribute returning nil
  def attr?(name)
    !attr(name).nil?
  end

  def method_missing(name, *args, &blk)
    attr?(name) ? attr(name) : super
  end

  def id
    attr(:id)
  end

  def_delegator :node, :isEnabled, :enabled?
  def_delegator :node, :getText, :text
  def_delegator :node, :getHTML, :html
  def_delegator :node, :getValue, :value
  def_delegator :node, :getElementName, :tag_name
  def_delegator :node, :clear, :clear


  # Events

  def click(x=0, y=0)
    node.click(x.to_i, y.to_i)
  end

  def click_async
    node.click 1
  end

  def double_click
    node.click 2
  end

  def triple_click
    node.click 3
  end

  def quadruple_click
    node.click 4
  end

  def right_click
    node.rightClick
  end

  def drag_and_drop_on(other)
    node.dragAndDropOn other.node
  end

  def_delegator :node, :submit


  # UI

  def screenshot(file_name, time_out)
    node.saveScreenshot(file_name, time_out)
  end

  def_delegator :node, :getImageHash, :visual_hash

  def location
    loc = node.getLocation
    {:x => loc.x.to_i, :y => loc.y.to_i}
  end


  # Finders

  def find_elements_by_id(value)
    node.findElementsById(value).to_a.map do |n|
      OperaWatir::Element.new(n)
    end
  end

  def find_elements_by_class(value)
    node.findElementsByClassName(value).to_a.map do |n|
      OperaWatir::Element.new(n)
    end
  end

  def find_elements_by_tag(value)
    node.findElementsByTagName(value).to_a.map do |n|
      OperaWatir::Element.new(n)
    end
  end

  def find_elements_by_css(value)
    node.findElementsByCssSelector(value).to_a.map do |n|
      OperaWatir::Element.new(n)
    end
  end

  def find_elements_by_xpath(value)
    node.findElementsByXpath(value).to_a.map do |n|
      OperaWatir::Element.new(n)
    end
  end

private

  attr_accessor :node

end
