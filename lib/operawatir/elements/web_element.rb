module OperaWatir
  class WebElement

    include Collections

    # The default way of finding an element
    # @return [:id]
    def self.default_method
      :id
    end

    # Inferrs the tagname from the classname
    # @note This isn't 100% perfect as WatirSpec imposes specific classnames for some tests.
    # @example
    #   class HoobaFaluba < WebElement; end
    #   HoobaFaluba.tag # => :hoobafaluba
    def self.tag
      name.split('::').last.downcase.to_sym
    end

    # @private
    def self.element_attr_reader(*attrs)
      attrs.each do |attr|
        define_method(attr.to_sym) { get_attribute(attr)}
      end
    end

    def self.new_with_element(container, element)
      elm = new(container)
      elm.element = element
      elm
    end

    attr_writer :element

    def element
      @element ||= find || raise(Exceptions::UnknownObjectException, "Element #{@selector} not found using #{@method}")
    end

    alias_method :elm, :element

    # @todo Document
    def initialize(container, method=nil, selector=nil, value=nil)
      @container, @value = container, value

      if method.nil? && selector.nil?
        @method, @selector = :index, 1
      elsif selector.nil?
        @method, @selector = self.class.default_method, method
      else
        @method, @selector = method, selector
      end
    end

    # @return [true, false] wether the element is enabled or not.
    def enabled?
      element.isEnabled
    end

    # @return [true, false] wether the element is disabled or not.
    def disabled?
      !enabled?
    end

    # @raise ObjectDisabledException unless the element is enabled.
    def assert_enabled
      raise Exceptions::ObjectDisabledException, "Element #{@method} and #{@selector} is disabled" unless enabled?
    end

    # @return [true, false] if the element exists or not.
    def exist?
      !!element
    rescue Exceptions::UnknownObjectException
      false
    end
    alias_method :exists?, :exist?

    # Clicks the element. Can specify the specic position to click.
    # @param Integer x
    # @param Integer y
    # @example
    #   image.click # Clicks the image at 0,0 (relative to the image)
    #   image.click(10, 10) # Clicks the image at 10,10 (relative to the image)
    def click(x=nil, y=nil)
      x.nil? && y.nil? ? element.click : element.click(x.to_i, y.to_i)
    end

    # Click the element and don't block waiting for a response.
    def click_no_wait
      element.click 1
    end

    # Click the element twice.
    def double_click
      element.click 2
    end

    # Click the element three times in a row.
    def triple_click
      element.click 3
    end

    # Click the element four times in a row.
    def quadruple_click
      element.click 4
    end

    # Right clock the element.
    def right_click
      element.rightClick
    end

    # Returns the text of the element
    def text
      element.getText
    end

    # Returns the value of an elements attribute
    # @param [#to_s] attribute name
    # @return [String] attribute value, or an empty string if the attribute doesn't exist
    def get_attribute(attr)
      element.getAttribute(attr.to_s) || ''
    end

    # @return [TrueClass, FalseClass] if the element's value includes some text.
    def include?(target)
      val = element.getValue
      return false if val.nil?
      val.include?(target)
    rescue Exceptions::UnknownObjectException
      false
    end

    alias_method :contains?, :include?
    alias_method :verify_contains, :include?

    # Submits an element
    # @example
    #   form.submit # Does what is expected
    #   button.submit # Doesn't do what is expected
    def submit
      element.submit
    end

    # Clears the element
    def clear
      element.clear
    end

    # @return text of the element. All suppounding whitespace is stripped.
    # @note if the element doesn't have any text an empty string is returned.
    def text
      (element.getText || '').strip
    end

    def html
      element.getHTML
    end

    # @return the value of the element
    def value
      element.getValue || ''
    end

    # @return the name of the element
    # @note this is overridden in a non-standard way with input fields.
    # @example
    #   button.type # => 'BUTTON'
    #   text_input_field.type # => 'text'
    def type
      element.getElementName
    end

    # Takes a screenshot of an element and saves it to a file.
    # @param [String] file_name The name of the file to be saved
    # @param [Numeric] time_out The number of seconds before execution stops.
    def take_screenshot(file_name, time_out)
      element.saveScreenshot(file_name, time_out)
    end

    # Drags and then drops the element on another element
    # @param other The other element
    def drag_and_drop_on(other)
      element.dragAndDropOn other
    end

    # @return a hash of an element, depending on what it looks like.
    # @example
    #   # <p>A paragraph</a>
    #   # <p style="color:red;">A paragraph</a>
    #   p1.visual_hash == p2.visual_hash # => false
    def visual_hash
      element.getImageHash
    end

    # @return [TrueClass, FalseClass] wether the element looks the same as another element
    def compare_hash(other)
      visual_hash == other.visual_hash
    end

    # @return {:x => Numeric, :y => Numeric} the x and y coordinates of the element
    def location
      loc = element.getLocation
      {:x => loc.x.to_i, :y => loc.y.to_i}
    end

    # @return [String] the outer HTML of the element
    def html
      element.getHTML
    end

    # @attr_reader String id
    def id
      get_attribute 'id'
    end

    # @attr_reader String element classes
    def class_name
      get_attribute 'class'
    end

    # @attr_reader String element name
    element_attr_reader :name

    # @attr_reader String element style
    element_attr_reader :style

    # @attr_reader String element index
    element_attr_reader :index

    # @attr_reader String element title
    element_attr_reader :title

  private

    # @private
    LEFT = 3
    # @private
    RIGHT = 12
    # @private
    MIDDLE = 48
    # @private
    LEFT_DOWN = 1
    # @private
    LEFT_UP = 2
    # @private
    RIGHT_DOWN = 4
    # @private
    RIGHT_UP = 8
    # @private
    MIDDLE_DOWN = 16
    # @private
    MIDDLE_UP = 32

    def self.xpath
      tag.to_s
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

    def mouse_action(x, y, *actions)
      sum = actions.inject(0){ |sum, item| sum + item}
      @container.driver.mouseEvent(x,y,sum)
    end

    def find
      raise TypeError unless @selector.is_a?(String) || @selector.is_a?(Regexp) || @selector.is_a?(Fixnum)

      # @todo webdriver-opera needs to accept regexes for findElementBy*
      #       +source+ is a hack.
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
        @container.driver.findElementByXPath("//#{self.class.xpath}[@href='#{@selector}']")
      when :title
        @container.driver.findElementByXPath("//#{self.class.xpath}[@title='#{@selector}']")
      when :alt
        @container.driver.findElementByXPath("//#{self.class.xpath}[@alt='#{@selector}']")
      when :src
        @container.driver.findElementByXPath("//#{self.class.xpath}[@src='#{@selector}']")
      when :index
        raise "watir index starts from 1" if @selector.to_i.zero?
        @container.driver.findElementByXPath("//descendant::#{self.class.xpath}[#{@selector.to_i}]")
      when :value
        @container.driver.findElementByXPath("//#{self.class.xpath}[@value='#{@selector}' or text()='#{@selector}']")
      when :text
        @container.driver.findElementByXPath("//#{self.class.xpath}[text()='#{@selector}']")
      when :class
        @container.driver.findElementByXPath("//#{self.class.xpath}[@class='#{@selector}']")
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


