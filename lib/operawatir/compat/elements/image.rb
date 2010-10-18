module OperaWatir::Compat::Elements
  class Image < WebElement

    element_attr_reader :src, :title

    # TODO

    def file_size
      raise NotImplementedException
    end

    def width
      raise NotImplementedException
    end

    def height
      raise NotImplementedException
    end

    def loaded?
      raise NotImplementedException
    end
    
  end
end

