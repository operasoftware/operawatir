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
        define_method(attr.to_sym) { element.get_attribute(attr)}
      end
    end

    def initialize(container, method=nil, selector=nil, value=nil)
      @container, @value = container, value

      case method
      when Symbol
        @method, @selector = method, selector
      when nil
        @method, @selector = :index, 1
      else
        @method, @selector = self.class.default_method, method
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

    def click(x=nil, y=nil)
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
      element.getAttribute(name.to_s) || ''
    end

    def contains?(target)
      return false unless exists?
      val = element.getValue
      return false if val.nil?
      val.include?(target)
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

    def text
      element.getValue
    end

    def type
      element.getElementName
    end

    def take_screenshot(file_name, time_out)
      element.saveScreenshot(file_name, time_out)
    end

    def drag_and_drop_on(other)
      element.dragAndDropOn other
    end

    def visual_hash
      element.getImageHash
    end

    def compare_hash(other)
      visual_hash == other.visual_hash
    end

    def location
      loc = element.getLocation
      {:x => loc.x.to_i, :y => loc.y.to_i}
    end

    def fire_event(event, x=0, y=0)
      x += location[:x]
      y += location[:y]

      case event
      when "onMouseOver"
        mouse_action(x,y)
      when "onMouseOut"
        mouse_action(x,y)
        mouse_action(0,0)
      when "onMouseDown"
        mouse_action(x, y, LEFT_DOWN)
      when "onMouseUp"
        mouse_action(x,y, LEFT_UP)
      when "onMouseMove"
        mouse_action(x,y)
        mouse_action(x+1,y+1)
      end
    end

    # Attributes

    def id
      get_attribute 'id'
    end

    def class_name
      get_attribute 'class'
    end

    element_attr_reader :name, :style

  private

    def element
      @elm ||= find || raise(Exceptions::UnknownObjectException, "Element #{@selector} not found using #{@method}")
    end

    alias_method :elm, :element

    def mouse_action(x, y, *actions)
      sum = actions.inject(0){ |sum, item| sum + item}
      @container.driver.mouseEvent(x,y,sum)
    end

    # TODO: webdriver-opera needs to accept regexes for findElement*
    #       to_s is a hack.
    def find
      raise TypeError unless @selector.is_a?(String) || @selector.is_a?(Regexp) || @selector.is_a?(Fixnum)

      case @method
      when :name
        if @value.nil?
          @container.driver.findElementByName(@selector.to_s)
        else
          @container.driver.findElementByXPath("//input[@name='#{@selector}' and @value='#{@value}']")
        end
      when :id
        @container.driver.findElementById(@selector.to_s)
      when :xpath
        @container.driver.findElementByXPath(@selector.to_s)
      when :selector
        @container.driver.findElementByCssSelector(@selector.to_s)
      when :text
        @container.driver.findElementByLinkText(@selector.to_s)
      when :href
        @container.driver.findElementByXPath("//a[@href='#{@selector}']")
      when :index
        raise "watir index starts from 1" if @selector.to_i.zero?
        @container.driver.findElementByXPath("//*[#{@selector.to_i+1}]")
      when :value
        @container.driver.findElementByXPath("//*[@value='#{@selector}' or text()='#{@selector}']")
      when :class
        @container.driver.findElementByXPath("//*[@class='#{@selector}']")
      when :tag_name
        @container.driver.findElementByTagName(@selector.to_s)
      else
        raise Exceptions::MissingWayOfFindingObjectException
      end
    rescue NoSuchElementException
      raise Exceptions::UnknownObjectException
    end
  end
end

