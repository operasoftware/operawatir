%w(web_element non_control_elements button checkbox element form image link
   radio select_list text_field).
   each { |elm| require "operawatir/elements/#{elm}" }

module OperaWatir
  module Elements

    # @todo DRY

    # Finds child {Area}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def area(method=nil, selector=nil, value=nil)
      Area.new self, method, selector, value
    end

    # Finds child {Button}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def button(method=nil, selector=nil, value=nil)
     Button.new self, method, selector, value
    end

    # Finds child {CheckBox}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def checkbox(method=nil, selector=nil, value=nil)
     CheckBox.new self, method, selector, value
    end

    # Finds child {Dd}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def dd(method=nil, selector=nil, value=nil)
      Dd.new self, method, selector, value
    end

    # Finds child {Del}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def del(method=nil, selector=nil, value=nil)
      Del.new self, method, selector, value
    end

    # Finds child {Div}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def div(method=nil, selector=nil, value=nil)
     Div.new self, method, selector, value
    end

    # Finds child {Dl}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def dl(method=nil, selector=nil, value=nil)
      Dl.new self, method, selector, value
    end

    # Finds child {Dt}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def dt(method=nil, selector=nil, value=nil)
      Dt.new self, method, selector, value
    end

    # Finds child {Element}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def element(method=nil, selector=nil, value=nil)
     Element.new self, method, selector, value
    end

    # Finds child {Em}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def em(method=nil, selector=nil, value=nil)
     Em.new self, method, selector, value
    end

    # Finds child {FileField}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def file_field(method=nil, selector=nil, value=nil)
     FileField.new self, method, selector, value
    end

    # Finds child {Form}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def form(method=nil, selector=nil, value=nil)
     Form.new self, method, selector, value
    end

    # @private
    def frame
      raise 'TODO'
    end

    # Finds child {Hidden}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def hidden(method=nil, selector=nil, value=nil)
     Hidden.new self, method, selector, value
    end

    # Finds child {H1}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def h1(method=nil, selector=nil, value=nil)
     H1.new self, method, selector, value
    end

    # Finds child {H2}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def h2(method=nil, selector=nil, value=nil)
     H2.new self, method, selector, value
    end

    # Finds child {H3}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def h3(method=nil, selector=nil, value=nil)
     H3.new self, method, selector, value
    end

    # Finds child {H4}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def h4(method=nil, selector=nil, value=nil)
     H4.new self, method, selector, value
    end

    # Finds child {H5}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def h5(method=nil, selector=nil, value=nil)
     H5.new self, method, selector, value
    end

    # Finds child {H6}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def h6(method=nil, selector=nil, value=nil)
     H6.new self, method, selector, value
    end

    # Finds child {Image}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def image(method=nil, selector=nil, value=nil)
     Image.new self, method, selector, value
    end

    # Finds child {Dd}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def ins(method=nil, selector=nil, value=nil)
     Ins.new self, method, selector, value
    end

    # Finds child {Label}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def label(method=nil, selector=nil, value=nil)
     Label.new self, method, selector, value
    end

    # Finds child {Link}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def link(method=nil, selector=nil, value=nil)
     Link.new self, method, selector, value
    end

    # Finds child {Li}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def li(method=nil, selector=nil, value=nil)
      Li.new self, method, selector, value
    end

    # Finds child {Map}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def map(method=nil, selector=nil, value=nil)
      Map.new self, method, selector, value
    end

    # Finds child {Meta}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def meta(method=nil, selector=nil, value=nil)
      Meta.new self, method, selector, value
    end

    # Finds child {Ol}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def ol(method=nil, selector=nil, value=nil)
     Ol.new self, method, selector, value
    end

    # Finds child {Option}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def option(method=nil, selector=nil, value=nil)
     Option.new self, method, selector, value
    end

    # Finds child {Pre}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def pre(method=nil, selector=nil, value=nil)
     Pre.new self, method, selector, value
    end

    # Finds child {P}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def p(method=nil, selector=nil, value=nil)
     P.new self, method, selector, value
    end

    # Finds child {Radio}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def radio(method=nil, selector=nil, value=nil)
     Radio.new self, method, selector, value
    end

    # Finds child {SelectList}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def select_list(method=nil, selector=nil, value=nil)
     SelectList.new self, method, selector, value
    end

    # Finds child {Span}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def span(method=nil, selector=nil, value=nil)
     Span.new self, method, selector, value
    end

    # Finds child {Strong}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def strong(method=nil, selector=nil, value=nil)
     Strong.new self, method, selector, value
    end

    # Finds child {TableBody}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def tbody(method=nil, selector=nil, value=nil)
      TableBody.new self, method, selector, value
    end

    # I'm aliasing this because body clashes.
    alias_method :body, :tbody

    # Finds child {TableCell}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def cell(method=nil, selector=nil, value=nil)
      TableCell.new self, method, selector, value
    end

    # Finds child {TableFooter}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def tfoot(method=nil, selector=nil, value=nil)
      TableFooter.new self, method, selector, value
    end

    # Finds child {TableHeader}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def thead(method=nil, selector=nil, value=nil)
      TableHeader.new self, method, selector, value
    end

    # Finds child {Row}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def row(method=nil, selector=nil, value=nil)
      Row.new self, method, selector, value
    end

    # Finds child {Table}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def table(method=nil, selector=nil, value=nil)
      Table.new self, method, selector, value
    end

    # Finds child {TextField}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def text_field(method=nil, selector=nil, value=nil)
     TextField.new self, method, selector, value
    end

    # Finds child {Ul}s given by the +method+, +selector+ and +value+
    # @see WebElement#initialize
    def ul(method=nil, selector=nil, value=nil)
     Ul.new self, method, selector, value
    end

  end
end
