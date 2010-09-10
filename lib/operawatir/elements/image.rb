module OperaWatir
  class Image < WebElement

    def self.tag
      :img
    end

    element_attr_reader :src, :title

    # TODO

    def file_size
    end

    def width
    end

    def height
    end

    def loaded?
    end

  end
end