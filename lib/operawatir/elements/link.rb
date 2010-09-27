module OperaWatir
  class Link < WebElement

    def self.default_method
      :href
    end

    element_attr_reader :href, :title

    alias_method :url, :href

  end
end

