%w(web_element non_control_elements button checkbox form image link
   radio select_list text_field).each {|elm| require "operawatir/elements/#{elm}"}

module OperaWatir
  module Elements

    def text_field(method=nil, selector=nil, value=nil)
     TextField.new self, method, selector, value
    end

    def form(method=nil, selector=nil, value=nil)
     Form.new self, method, selector, value
    end

    def button(method=nil, selector=nil, value=nil)
     Button.new self, method, selector, value
    end

    def link(method=nil, selector=nil, value=nil)
     Link.new self, method, selector, value
    end

    def select_list(method=nil, selector=nil, value=nil)
     SelectList.new self, method, selector, value
    end

    def checkbox(method=nil, selector=nil, value=nil)
     CheckBox.new self, method, selector, value
    end

    def radio(method=nil, selector=nil, value=nil)
     Radio.new self, method, selector, value
    end

    def area(method=nil, selector=nil, value=nil)
     Area.new self, method, selector, value
    end

    def image(method=nil, selector=nil, value=nil)
     Image.new self, method, selector, value
    end

    def div(method=nil, selector=nil, value=nil)
     Div.new self, method, selector, value
    end

    def p(method=nil, selector=nil, value=nil)
     P.new self, method, selector, value
    end

    def element(method=nil, selector=nil, value=nil)
     Element.new self, method, selector, value
    end

    def hidden(method=nil, selector=nil, value=nil)
     Hidden.new self, method, selector, value
    end

    def file_field(method=nil, selector=nil, value=nil)
     FileField.new self, method, selector, value
    end

    def ul(method=nil, selector=nil, value=nil)
     Ul.new self, method, selector, value
    end

    def span(method=nil, selector=nil, value=nil)
     Span.new self, method, selector, value
    end
  end
end
