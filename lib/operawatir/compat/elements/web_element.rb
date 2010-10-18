module OperaWatir::Compat::Elements
  class WebElement

    def self.default_method
      :id
    end

    def self.element_attr_reader(*attrs)
      attrs.each do |attr|
        define_method(attr.to_sym) { element.get_attribute(attr) }
      end
    end

    def initialize(container, method = nil, selector = nil, value = nil)
      @container, @value = container, value

      if method.is_a? OperaWebElement
        @elm = method
      elsif method.nil? && selector.nil?
        @method, @selector = :index, 1
      elsif selector.nil?
        @method, @selector = self.class.default_method, method
      else
        @method, @selector = method, selector
      end
    end

  end
end

