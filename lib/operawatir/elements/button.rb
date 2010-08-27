module OperaWatir
  class Button < WebElement

    def src
      get_attribute 'src'
    end

  end
end
