module OperaWatir
  class Link < WebElement

    def self.default_method
      :href
    end

    def href
      get_attribute 'href'
    end
    alias_method :url, :href

    def title
      get_attribute 'title'
    end

  end
end
