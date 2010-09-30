module OperaWatir
  # Class for +a+ elements
  class Link < WebElement

    # @return [:href]
    def self.default_method(foo)
      :href
    end

    # @return [:img] the html tag of the element
    def self.tag
      :a
    end

    element_attr_reader :href
    alias_method :url, :href

    element_attr_reader :title
  end
end
