class OperaWatir::Element
  extend Forwardable

  def initialize(node)
    self.node = node
  end

  # TODO Need support for this in Webdriver
  def hash
    node.hashCode
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
  def has_attribute?(name)
    !attr(name).nil?
  end

  def method_missing(method, *args, &blk)
    if !(block_given? || !args.empty?) && has_attribute?(method)
      attr(method)
    else
      super
    end
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
  def_delegator :node, :isSelected, :checked?

  def_delegator :node, :setSelected, :select

  def_delegator :node, :isSelected, :selected?

  def_delegator :node, :toggle, :toggle_check!

  def_delegator :node, :getText, :text
  def_delegator :node, :getHTML, :html

  def_delegator :node, :getElementName, :tag_name
  def_delegator :node, :clear, :clear

  # On elements of type `input`, `textarea` or `select` it will fetch
  # the texteditable `value` attribute, on every other element type it
  # returns the DOM attribute `value`.
  #
  # @return [String] Value of the element.
  def value
=begin
    if tag_name =~ /input|textarea|select/i
      node.getValue  #
    elsif tag_name =~ /button/i
      text           # getVisibleContents
    else
      attr :value    # attribute @value
    end
=end

    node.getValue
  end

  #
  # Does the element exist in the DOM?
  #
  # @return [Boolean] True if element exists, false otherwise.
  #

  def exist?
    !!!tag_name.empty?
  end

  alias_method :exists?, :exist?  # LOL Ruby

  def disabled?
    !enabled?
  end

  def check!
    node.toggle if not selected?
  end

  def uncheck!
    node.toggle if selected?
  end


  # Events

  #
  # Clicks on the top left of the element, or the given x,y offset
  # relative to the element.
  #
  # @param [Integer] x The offset from the top left of the element.
  # @param [Integer] y The offset from the top of the element.
  #

  def click(x=1, y=1)
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

  def middle_click
    node.middleClick
  end

  def drag_and_drop_on(other)
    node.dragAndDropOn other.node
  end

  def drag_and_drop_by(x, y)
    node.dragAndDropBy(x.to_i, y.to_i)
  end

  def_delegator :node, :submit, :submit!

  def text=(input)
    if attr(:type) =~ /checkbox/i
      toggle_check! unless checked?
    else
      # Focus before typing
      clear unless value.empty?
      node.sendKeys(input.to_s.split('').to_java(:string))
    end
  end

  alias_method :set, :text=
  alias_method :value=, :text=

  def send_keys(*list)
    raise Exceptions::NotImplementedException
  end

  # FIXME: This should be migrated to using browserbot.js, as watir-webdriver
  # is using.
  def fire_event(event, x = 0, y = 0)
    loc = location
    x += loc[:x]
    y += loc[:y]

    # In the case that event is given as symbol, we convert it to a
    # string.
    event = event.to_s
    event =~ /on(.*)/i
    event = $1 if $1
    event = event.downcase.to_sym

    case event
    when :abort, :blur, :change, :error, :focus, :load, :reset, :resize, :scroll, :submit, :unload
      type = 'HTMLEvents';
      init = "initEvent(\"#{event.to_s}\", true, true)"
    when :click, :dblclick, :mousedown, :mousemove, :mouseout, :mouseover, :mouseup
      type = 'MouseEvents'
      init = "initMouseEvent(\"#{event.to_s}\", true, true, window, 1, 0, 0, 0, 0, false, false, false, false, 0, null)"
    else
      raise Exceptions::NotImplementedException, "Event on#{event} is not a valid ECMAscript event for OperaWatir."
    end

    script = "var event = document.createEvent(\"#{type}\"); " +
      "event.#{init}; " +
      "locator.dispatchEvent(event);"

    node.callMethod(script)
  end

  def visible?
    node.isVisible
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


private

  attr_accessor :node

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

  def find_elements_by_name(value)
    node.findElementsByName(value).to_a.map do |n|
      OperaWatir::Element.new(n)
    end
  end

end
