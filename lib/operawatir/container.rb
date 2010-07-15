module OperaWatir
  module Container

    def text_field(how,what)
      return TextField.new(self,how,what)
    end

    def form(how,what)
      return Form.new(self,how,what)
    end

    def button(how,what=nil)
      if what.nil?
        return Button.new(self,:value,how)
      end
      return Button.new(self,how,what)
    end

    def link(how,what)
      return Link.new(self, how,what)
    end

    def select_list(how, what=nil)
      return SelectList.new(self, how, what)
    end

    def checkbox(how, what=nil, value=nil)
      return CheckBox.new(self, how, what, value)
    end

    def radio(how, what=nil, value=nil)
      return Radio.new(self, how, what, value)
    end

    def area(how,what)
      return Area.new(self,how,what)
    end

    def image(how,what)
      return Image.new(self,how,what)
    end

    def div(how,what)
      return Div.new(self,how,what)
    end

    def p(how,what)
      return P.new(self,how,what)
    end
    
    def element(how,what)
      return Element.new(self,how,what)
    end

    def hidden(how,what)
      return Hidden.new(self,how,what)
    end

    def file_field(how,what)
      return FileField.new(self,how,what)
    end

    def ul(how,what)
      return Ul.new(self,how,what)
    end

    def span(how,what)
      return Span.new(self,how,what)
    end

  end
end
