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

    # Locate the element on the page.  Elements can be located using one
    # of the following selectors:
    #
    # * name
    # * id
    # * xpath
    # * selector
    # * text
    # * href
    # * index
    # * value
    # * class
    # * tag_name
    #
    # Raises:
    # NoSuchElementException:  if element is not found.
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

    # Returns true if the element is enabled, false if it isn't.  First
    # checks if element exists or not.  Then checks if element is enabled
    # or not.
    #
    # Output: 
    #   Returns true if element exists and is enabled, else returns
    #   false.
    #
    # Raises:
    # NoSuchElementException:  if element is not found.
    def enabled?
      locate
      return @element.isEnabled
    end

    # Checks if element is enabled or not.
    #
    # Raises:
    # ObjectDisabledException::  if element is disabled and you are attempting to use it.
    def assert_enabled
      raise ObjectDisabledException, "Element #{@how} and #{@what} is disabled" unless enabled?
    end

    # Checks whether element exists or not.
    #
    # Raises:
    # NoSuchElementException::  if element is is not found.
    def assert_exists
      locate
      unless @element
        raise NoSuchElementException, "Element #{@what} not found using #{@how}"
      end
    end

    # Checks whether element exists or not.
    #
    # Raises:
    # NoSuchElementException::  if element is is not found.
    def exists?
      assert_exists
      true
    rescue NoSuchElementException
      false
    end
    alias_method :exist?, :exists?

    # This method clicks the active element.  If optional arguments +x+
    # and +y+ are given, it clicks designated area on the screen
    # instead.
    #
    # Raises:
    # NoSuchElementException::   if the element is not found.
    # ObjectDisabledException::  if the element is currently disabled.
    def click(x = 0,y = 0)
      assert_exists
      if(x.eql?(0) && y.eql?(0))
          @element.click()
      else
          @element.click(x,y)
      end
    end

    # +click_no_wait+ method will click active element and go directly
    # on to the following command.  While +click+ method waits for a
    # response/action from the browser, +click_no_wait+ will i.e. not
    # wait for a new page loading.
    #
    # Raises:
    # NoSuchElementException::   if the element is not found.
    # ObjectDisabledException::  if the element is currently disabled.
    def click_no_wait
      assert_exists
      @element.click(1)
    end

    # Method will double click active element.
    #
    # Raises:
    # NoSuchElementException::   if the element is not found.
    # ObjectDisabledException::  if the element is currently disabled.
    def double_click
      assert_exists
      @element.click(2)
    end

    # Method will perform three consecutive clicks on active element.
    # Some features in the Opera web browser requires a triple click to
    # be activated.
    #
    # Raises:
    # NoSuchElementException::   if the element is not found.
    # ObjectDisabledException::  if the element is currently disabled.
    def triple_click
      assert_exists
      @element.click(3)
    end

    # Method will perform four consecutive clicks on active element.
    # Some features in the Opera web browser requires a quadruple click
    # to be activated.
    #
    # Raises:
    # NoSuchElementException::   if the element is not found.
    # ObjectDisabledException::  if the element is currently disabled.
    def quadruple_click
      assert_exists
      @element.click(4)
    end

    def multiple_click(count)
      assert_exists
      @element.click(count.to_i)
    end
    private :multiple_click

    # Right clicks the active element.
    #
    # Raises:
    # NoSuchElementException::   if the element is not found.
    # ObjectDisabledException::  if the element is currently disabled.
    def right_click
      assert_exists
      @element.rightClick
    end    

    # Return the innerText of the active element.
    #
    # Raises:
    # NoSuchElementException::   if the element is not found.
    def text
      assert_exists
      return @element.getText
    end

    # Returns the value of the specified attribute of an element.
    #
    # Raises:
    # NoSuchElementException::   if the element is not found.
    def attribute_value(attribute_name)
      assert_exists
      return @element.getAttribute(attribute_name)
    end

    # Checks if the provided text matches with the contents of text
    # field.  Text can be a string or regular expression.
    #
    # Input: 
    # target::  text to be verified.
    #
    # Output:
    #   True if provided text matches with the contents of text field,
    #   false otherwise.
    def verify_contains(target)
      return false unless exists?
      val = @element.getValue
      return false if val.nil?
      val.include?(target)
    end

    # Submits the active form.  Equivalent to pressing +Enter+ or
    # +Return+ to submit a form.
    #
    # Raises:
    # NoSuchElementException::  if the element is not found.
    def submit
      assert_exists
      @element.submit
    end

    # Clears the contents of the element, typically an input type text
    # field.
    #
    # Raises:
    # NoSuchElementException::   if the element is not found.
    # ObjectDisabledException::  if text field is disabled.
    # ObjectReadOnlyException::  if text field is read-only.
    def clear
      assert_exists
      @element.clear
    end

    # Returns a string representation of the element.  Typically, the
    # value of a text field, &c.
    #
    # Raises:
    # NoSuchElementException::  if the element is not found.
    def to_s
      assert_exists
      @element.getValue
    end

    # Takes a screenshot of active element.  
    #
    # Input:
    # file_name::  the absolute file path you wish to save the screenshot to.
    # time_out::   means get hash and compare it until that timeout.  If a match is found, you get back the response, otherwise you get the last response (that is from the timeout). The timeout parameter is not necessary if taking a screenshot of a single element.
    #
    # Raises:
    # NoSuchElementException::  if the element is not found.
    def take_screenshot(file_name,time_out)
        assert_exists
        @element.saveScreenshot(file_name,time_out)
    end

    # Drags active element and drops it on the specified element.
    # Typically for moving movable elements around on a web page.
    #
    # Input:
    # element::  name of the designated element where active element will be dropped
    #
    # Raises:
    # NoSuchElementException::  if either of the elements is not found.
    def drag_and_drop_on(element)
      assert_exists
      element.assert_exists
      @element.dragAndDropOn(element)
    end

    # Will return the hash of the visual representation of the active
    # element, which can be used for reference tests.
    #
    # Raises:
    # NoSuchElementException::  if the element is not found.
    def get_hash
      assert_exists
      @element.getImageHash
    end

    # Lets you visually compare active element and provided element in
    # argument.
    #
    # Input:
    # element::  reference to the other element you wish compared with active element.
    #
    # Output:
    #   True or false
    #
    # Example:
    #
    #   > @browser.text_field(:id, "a").compare_hash(@browser.text_field(:id, "b"))
    #   ==> true
    #
    # Raises:
    # NoSuchElementException::  if (either) element is not found.
    def compare_hash(element)
      assert_exists
      element.assert_exists
      self.get_hash.eql?(element.get_hash)
    end

    # Returns a hash with the the +x+ and +y+ location of active element.
    #
    # Output:
    #   { x => 1, y => 2 }
    #
    # Raises:
    # NoSuchElementException::  if the element is not found.
    def get_location
      assert_exists
      {'x' => @element.getLocation.x.to_i, 'y' => @element.getLocation.y.to_i}
    end

    def getLocation
      @element.getLocation
    end
    private(:getLocation)

    # Lets you fire an ECMAscript event on the current page.  By
    # supplying +x+ and +y+ arguments it will also allow you to fire off
    # an event in a specified location on the page.
    #
    # Arguments:
    # event::  name of the ECMAscript/JavaScript event you would like to fire.  (I.e. “onMouseOver”, “onMouseMove”, &c.)
    # x::      (Optional.)  x coordinate lets you specify where the event should take place on the page.
    # y::      (Optional.)  y coordinate lets you specify where the event should take place on the page.
    #
    # Raises:
    # NoSuchElementException::  if the elemnt is not found.
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

