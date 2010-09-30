module OperaWatir
  # Class for +img+ elements
  class Image < WebElement

    # @return [:img] the html tag of the element
    def self.tag
      :img
    end

    element_attr_reader :src, :title, :alt

    # @todo
    def file_size
    end

    # @todo
    def width
    end

    # @todo
    def height
    end

    # @todo
    def loaded?
    end

  end
end
