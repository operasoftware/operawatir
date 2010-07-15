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

    def initialize(container,how,what)
      @container,@how, @what = container, how, what
    end
    
    def locate
      case @how
      when :name
        if @value.nil?
          @element = @container.driver.findElementByName(@what)
        else
          @element = @container.driver.findElementByXPath("//input[@name='#{@what}' and @value='#{@value}']")
        end
      when :id
        @element = @container.driver.findElementById(@what)
      when :xpath
        @element = @container.driver.findElementByXPath(@what)
      when :selector
        @element = @container.driver.findElementByCssSelector(@what)
      when :text
        @element = @container.driver.findElementByLinkText(@what)
      when :href
        @element = @container.driver.findElementByXPath("//a[@href='#{@what}']")
      when :index
        raise "watir index starts from 1" if @what.eql?(0)
        @element = @container.driver.findElementByXPath("//*[#{@what+1}]")
      when :value
        @element = @container.driver.findElementByXPath("//*[@value='#{@what}' or text()='#{@what}']")
      when :class
        @element = @container.driver.findElementByXPath("//*[@class='#{@what}']")
      when :tag_name
        @element = @container.driver.findElementByTagName(@what)
      end
    end

    def enabled?
      locate
      return @element.isEnabled
    end

    def assert_enabled
      raise ObjectDisabledException, "Element #{@how} and #{@what} is disabled" unless enabled?
    end

    def assert_exists
      locate
      unless @element
        raise NoSuchElementException, "Element #{@what} not found using #{@how}"
      end
    end

    def exists?
      assert_exists
      true
    rescue NoSuchElementException
      false
    end
    alias_method :exist?, :exists?

    def click(x = 0,y = 0)
      assert_exists
      if(x.eql?(0) && y.eql?(0))
          @element.click()
      else
          @element.click(x,y)
      end
    end

    def click_no_wait
      assert_exists
      @element.click(1)
    end

    def double_click
      assert_exists
      @element.click(2)
    end

    def triple_click
      assert_exists
      @element.click(3)
    end

    def quadruple_click
      assert_exists
      @element.click(4)
    end

    def multiple_click(count)
      assert_exists
      @element.click(count.to_i)
    end
    private :multiple_click

    def right_click
      assert_exists
      @element.rightClick
    end    

    def text
      assert_exists
      return @element.getText
    end

    def attribute_value(attribute_name)
      assert_exists
      return @element.getAttribute(attribute_name)
    end

    def verify_contains(target)
      return false unless exists?
      val = @element.getValue
      return false if val.nil?
      val.include?(target)
    end

    def submit
      assert_exists
      @element.submit
    end

    def clear
      assert_exists
      @element.clear
    end

    def to_s
      assert_exists
      @element.getValue
    end

    def take_screenshot(file_name,time_out)
        assert_exists
        @element.saveScreenshot(file_name,time_out)
    end

    def drag_and_drop_on(element)
      assert_exists
      element.assert_exists
      @element.dragAndDropOn(element)
    end

    def get_hash
      assert_exists
      @element.getImageHash
    end

    def compare_hash(element)
      assert_exists
      element.assert_exists
      self.get_hash.eql?(element.get_hash)
    end

    def get_location
      assert_exists
      {'x' => @element.getLocation.x.to_i, 'y' => @element.getLocation.y.to_i}
    end

    def getLocation
      @element.getLocation
    end
    private(:getLocation)


    def fire_event(event, x = 0, y= 0)
      assert_exists
      
      location = get_location
      x += location['x'];
      y += location['y'];


      case event
      when 'onMouseOver'
        mouse_action(x,y)
      when 'onMouseOut'
        mouse_action(x,y)
        mouse_action(0,0)
      when 'onMouseDown'
        mouse_action(x, y, LEFT_DOWN)
      when 'onMouseUp'
        mouse_action(x,y, LEFT_UP)
      when 'onMouseMove'
        mouse_action(x,y)
        mouse_action(x+1,y+1)
      end
    end

    def mouse_action(x, y, *action)
      sum = action.inject(0){|sum,item| sum + item}
      @container.driver.mouseEvent(x,y,sum)
    end

  end
end
