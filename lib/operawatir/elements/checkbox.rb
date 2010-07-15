module OperaWatir
  class CheckBox < WebElement
    def initialize(container,how,what,value)
      @container,@how, @what, @value= container,how,what,value
    end
    def set(value = true)
      assert_exists
      result = @element.toggle
      if(result != value)
        @element.toggle
      end
    end
    def checked?
      assert_exists
      @element.isSelected
    end
  end
end
