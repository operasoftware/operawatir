class OperaWatir::Element
  extend Forwardable

  def initialize(node)
    self.node = node
  end
  
  # TODO Need support for this in Webdriver
  def hash
    node.hash
  end
  
  def ==(other)
    node.equals other.node
  end
  
  def eql?(other)
    is_a?(other.class) && self == other
  end
  
  def hash
    node.hashCode
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
  
  def type
    attr(:type)
  end
  
  def class_name
    attr(:class)
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

  def text=(string)
    node.sendKeys(string.split(//).to_java(:string))
  end

  def fire_event(event, x = 0, y = 0)
    x += location[:x]
    y += location[:y]

    # In the case that event is given as symbol, we convert it to a
    # string.
    event = event.to_s
    event =~ /on(.*)/i
    event = $1 if $1
    event = event.downcase.to_sym

    # TODO: Should this be moved to OperaDriver instead?
    case event
    when :abort, :blur, :change, :error, :focus, :load, :reset,
      :resize, :scroll, :submit, :unload
      type = 'HTMLEvents';
      init = "initEvent(\"#{event.to_s}\", true, true)"
    when :click, :dblclick, :mousedown, :mousemove, :mouseout,
      :mouseover, :mouseup
      type = 'MouseEvents'
      init = "initMouseEvent(\"#{event.to_s}\", true, true, window, 1, 0, 0, 0, 0, false, false, false, false, 0, null)"
    else
      raise Exceptions::NotImplementedException,
      "Event on#{event} is not a valid ECMAscript event for OperaWatir."
    end

    script = "var event = document.createEvent(\"#{type}\"); " +
      "event.#{init}; " +
      "locator.dispatchEvent(event);"

    node.callMethod(script)
  end


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

  def find_elements_by_class_name(value)
    node.findElementsByClassName(value).to_a.map do |n|
      OperaWatir::Element.new(n)
    end
  end

  def find_elements_by_tag_name(value)
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
    node.findElementsByXPath(value).to_a.map do |n|
      OperaWatir::Element.new(n)
    end
  end

# private

  attr_accessor :node

end
