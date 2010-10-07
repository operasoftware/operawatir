module OperaWatir
  class WebElement

    LEFT = 3
    RIGHT = 12
    MIDDLE = 48
    LEFT_DOWN = 1
    LEFT_UP = 2
    RIGHT_DOWN = 4
    RIGHT_UP = 8
    MIDDLE_DOWN = 16
    MIDDLE_UP = 32

    def self.default_method
      :id
    end

    def self.element_attr_reader(*attrs)
      attrs.each do |attr|
        define_method(attr.to_sym) { element.get_attribute(attr) }
      end
    end

    def initialize(container, method = nil, selector = nil, value = nil)
      @container, @value = container, value

      if method.is_a? OperaWebElement
        @elm = method
      elsif method.nil? && selector.nil?
        @method, @selector = :index, 1
      elsif selector.nil?
        @method, @selector = self.class.default_method, method
      else
        @method, @selector = method, selector
      end
    end

    def enabled?
      element.isEnabled
    end

    def assert_enabled
      raise Exceptions::ObjectDisabledException, "Element #{@method} and #{@selector} is disabled" unless enabled?
    end

    def exist?
      !!element
    rescue Exceptions::UnknownObjectException
      false
    end
    alias_method :exists?, :exist?

    def click(x = nil, y = nil)
      x.nil? && y.nil? ? element.click : element.click(x.to_i, y.to_i)
    end

    def click_no_wait
      element.click 1
    end

    def double_click
      element.click 2
    end

    def triple_click
      element.click 3
    end

    def quadruple_click
      element.click 4
    end

    def right_click
      element.rightClick
    end

    def text
      element.getText
    end

    def get_attribute(name)
      element.getAttribute(name.to_s) || ""
    end
    alias_method :attribute_value, :get_attribute

    def contains?(target)
      val = element.getValue
      return false if val.nil?
      val.include?(target)
    rescue Exceptions::UnknownObjectException
      false
    end
    alias_method :verify_contains, :contains?

    def submit
      element.submit
    end

    def clear
      element.clear
    end

    def value
      element.getValue
    end
    alias_method :text, :value
    alias_method :to_s, :value

    def type
      element.getElementName
    end

    # TODO
    def disabled?
      false
    end

    def take_screenshot(file_name, time_out = 0)
      element.saveScreenshot(file_name, time_out)
    end

    def drag_and_drop_on(other)
      element.dragAndDropOn other
    end

    def visual_hash
      element.getImageHash
    end

    def get_hash
      warn "`get_hash' is deprecated.  Use `visual_hash' instead."
      visual_hash
    end

    def compare_hash(other)
      visual_hash == other.visual_hash
    end

    def location
      loc = element.getLocation
      {:x => loc.x.to_i, :y => loc.y.to_i}
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
        type = "HTMLEvents";
        init = "initEvent(\"#{event.to_s}\", true, true)"
      when :click, :dblclick, :mousedown, :mousemove, :mouseout,
        :mouseover, :mouseup
        type = "MouseEvents"
        init = "initMouseEvent(\"#{event.to_s}\", true, true, window, 1, 0, 0, 0, 0, false, false, false, false, 0, null)"
      else
        raise Exceptions::NotImplementedException,
          "Event on#{event} is not a valid ECMAscript event for OperaWatir."
      end

      script = "var event = document.createEvent(\"#{type}\"); " +
        "event." + init + "; " +
        "locator.dispatchEvent(event);"

      element.callMethod(script);
          
=begin
      case event
      when /^onMouseOver/i
        mouse_action(x, y)
      when /^onMouseOut/i
        mouse_action(x, y)
        mouse_action(0, 0)
      when /^onMouseDown/i
        mouse_action(x, y, LEFT_DOWN)
      when /^onMouseUp/i
        mouse_action(x, y, LEFT_UP)
      when /^onMouseMove/i
        mouse_action(x, y)
        mouse_action(x + 1, y + 1)
      when /^(onClick|onFocus)/i
        click
      when /^onDblClick/i
        double_click
      when /^onBlur/i
        click
        click(0, 0)
      when /^onScroll/i
        @container.key "Down"
        @container.key "Up"
      when /^(onAbort|onChange|onError|onLoad|onReset|onResize|
              onSelect|onSubmit|onUnload)/i
        raise Exceptions::NotImplementedException,
          "Event #{event} has not been implemented for use with fire_event method yet."
      end
=end
    end

    # Attributes

    def id
      get_attribute "id"
    end

    def class_name
      get_attribute "class"
    end

    element_attr_reader :name, :style

  private

    def element
      @elm ||= find || raise(Exceptions::UnknownObjectException, "Element #{@selector} not found using #{@method}")
    end
    alias_method :elm, :element

    def mouse_action(x, y, *actions)
      sum = actions.inject(0) { |sum, item| sum + item }
      @container.driver.mouseEvent(x, y, sum)
    end

    def find
      raise TypeError unless @selector.is_a?(String) || @selector.is_a?(Regexp) || @selector.is_a?(Fixnum)

      # TODO: webdriver-opera needs to accept regexes for findElementBy*
      #       `source` is a hack.
      @selector = @selector.source if @selector.is_a?(Regexp)

      case @method
      when :name
        if @value.nil?
          @container.driver.findElementByName(@selector)
        else
          @container.driver.findElementByXPath("//input[@name='#{@selector}' and @value='#{@value}']")
        end
      when :id
        @container.driver.findElementById(@selector)
      when :xpath
        @container.driver.findElementByXPath(@selector)
      when :selector
        @container.driver.findElementByCssSelector(@selector)
      when :text
        @container.driver.findElementByLinkText(@selector)
      when :href, :url
        @container.driver.findElementByXPath("//a[@href='#{@selector}']")
      when :title
        @container.driver.findElementByXPath("//*[@title='#{@selector}']")
      when :index
        raise "watir index starts from 1" if @selector.to_i.zero?
        @container.driver.findElementByXPath("//*[#{@selector.to_i + 1}]")
      when :value
        @container.driver.findElementByXPath("//*[@value='#{@selector}' or text()='#{@selector}']")
      when :class
        @container.driver.findElementByXPath("//*[@class='#{@selector}']")
      when :tag_name
        @container.driver.findElementByTagName(@selector)
      else
        raise Exceptions::MissingWayOfFindingObjectException
      end
    rescue NoSuchElementException
      raise Exceptions::UnknownObjectException, "Unable to locate #{self.class}, using #{@method} and #{@selector.inspect}"
    end
  end
end

