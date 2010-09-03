%w(web_element non_control_elements button checkbox form image link radio
   select_list text_field file_field).
   each { |elm| require "operawatir/elements/#{elm}" }

module OperaWatir
  module Elements

    # TODO Dry

    def area(mehtod=nil, selector=nil, value=nil)
      Area.new self, method, selector, value
    end

    def button(method=nil, selector=nil, value=nil)
     Button.new self, method, selector, value
    end

    def checkbox(method=nil, selector=nil, value=nil)
     CheckBox.new self, method, selector, value
    end

    def dd(method=nil, selector=nil, value=nil)
      Dd.new self, method, selector, value
    end

    def del(method=nil, selector=nil, value=nil)
      Del.new self, method, selector, value
    end

    def div(method=nil, selector=nil, value=nil)
     Div.new self, method, selector, value
    end

    def dl(method=nil, selector=nil, value=nil)
      Dl.new self, method, selector, value
    end

    def dt(method=nil, selector=nil, value=nil)
      Dt.new self, method, selector, value
    end

    def element(method=nil, selector=nil, value=nil)
     Element.new self, method, selector, value
    end

    def em(method=nil, selector=nil, value=nil)
     Em.new self, method, selector, value
    end

    def file_field(method=nil, selector=nil, value=nil)
     FileField.new self, method, selector, value
    end

    def form(method=nil, selector=nil, value=nil)
     Form.new self, method, selector, value
    end

    def frame
      raise 'TODO'
    end

    def hidden(method=nil, selector=nil, value=nil)
     Hidden.new self, method, selector, value
    end

    def h1(method=nil, selector=nil, value=nil)
     H1.new self, method, selector, value
    end

    def h2(method=nil, selector=nil, value=nil)
     H2.new self, method, selector, value
    end

    def h3(method=nil, selector=nil, value=nil)
     H3.new self, method, selector, value
    end

    def h4(method=nil, selector=nil, value=nil)
     H4.new self, method, selector, value
    end

    def h5(method=nil, selector=nil, value=nil)
     H5.new self, method, selector, value
    end

    def h6(method=nil, selector=nil, value=nil)
     H6.new self, method, selector, value
    end

    def image(method=nil, selector=nil, value=nil)
     Image.new self, method, selector, value
    end

    def ins(method=nil, selector=nil, value=nil)
     Ins.new self, method, selector, value
    end

    def label(method=nil, selector=nil, value=nil)
     Label.new self, method, selector, value
    end

    def link(method=nil, selector=nil, value=nil)
     Link.new self, method, selector, value
    end

    def li(method=nil, selector=nil, value=nil)
      Li.new self, method, selector, value
    end

    def map(method=nil, selector=nil, value=nil)
      Map.new self, method, selector, value
    end

    def meta(method=nil, selector=nil, value=nil)
      Meta.new self, method, selector, value
    end

    def ol(method=nil, selector=nil, value=nil)
     Ol.new self, method, selector, value
    end

    def option(method=nil, selector=nil, value=nil)
     Option.new self, method, selector, value
    end

    def pre(method=nil, selector=nil, value=nil)
     Pre.new self, method, selector, value
    end

    def p(method=nil, selector=nil, value=nil)
     P.new self, method, selector, value
    end

    def radio(method=nil, selector=nil, value=nil)
     Radio.new self, method, selector, value
    end

    def select_list(method=nil, selector=nil, value=nil)
     SelectList.new self, method, selector, value
    end

    def span(method=nil, selector=nil, value=nil)
     Span.new self, method, selector, value
    end

    def strong(method=nil, selector=nil, value=nil)
     Strong.new self, method, selector, value
    end

    def tbody(method=nil, selector=nil, value=nil)
      TableBody.new self, method, selector, value
    end

    def cell(method=nil, selector=nil, value=nil)
      Cell.new self, method, selector, value
    end

    def tfoot(method=nil, selector=nil, value=nil)
      TableFooter.new self, method, selector, value
    end

    def thead(method=nil, selector=nil, value=nil)
      TableHeader.new self, method, selector, value
    end

    def row(method=nil, selector=nil, value=nil)
      Row.new self, method, selector, value
    end

    def table(method=nil, selector=nil, value=nil)
      Table.new self, method, selector, value
    end

    def text_field(method=nil, selector=nil, value=nil)
     TextField.new self, method, selector, value
    end

    def ul(method=nil, selector=nil, value=nil)
     Ul.new self, method, selector, value
    end

  end
end
