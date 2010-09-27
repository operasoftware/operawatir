module OperaWatir
  module Collections

    def areas
      Collection.new(@driver.findElementsByTagName("areas").map { |element| OperaWatir::Area.new(self, element) } )
    end

    def buttons
      Collection.new(@driver.findElementsByTagName("button").map { |element| OperaWatir::Button.new(self, element) } )
    end

    def checkboxes
      Collection.new(@driver.findElementsByTagName("checkbox").map { |element| OperaWatir::CheckBox.new(self, element) } )
    end

    def dds
      Collection.new(@driver.findElementsByTagName("dd").map { |element| OperaWatir::Dd.new(self, element) } )
    end

    def dels
      Collection.new(@driver.findElementsByTagName("del").map { |element| OperaWatir::Del.new(self, element) } )
    end

    def divs
      Collection.new(@driver.findElementsByTagName("div").map { |element| OperaWatir::Div.new(self, element) } )
    end

    def dls
      Collection.new(@driver.findElementsByTagName("dl").map { |element| OperaWatir::Dl.new(self, element) } )
    end

    def dts
      Collection.new(@driver.findElementsByTagName("dt").map { |element| OperaWatir::Dt.new(self, element) } )
    end

    def elements(method = nil, selector = nil, value = nil)
      # FIXME:  Needs to fetch element-specific functionality.
      Collection.new(@driver.findElementsByXPath(selector).map { |element| OperaWatir::Element.new(self, element) } )
    end

    def ems
      Collection.new(@driver.findElementsByTagName("em").map { |element| OperaWatir::Em.new(self, element) } )
    end

    def file_fields
      Collection.new(@driver.findElementsByTagName("input[type=file]").map { |element| OperaWatir::FileField.new(self, element) } )
    end

    def forms
      Collection.new(@driver.findElementsByTagName("form").map { |element| OperaWatir::Form.new(self, element) } )
    end

    def frames
      Collection.new(@driver.findElementsByTagName("frame").map { |element| OperaWatir::Frame.new(self, element) } )
    end

    def hiddens
      Collection.new(@driver.findElementsByTagName("input[type=hidden]").map { |element| OperaWatir::Hidden.new(self, element) } )
    end

    def h1s
      Collection.new(@driver.findElementsByTagName("h1").map { |element| OperaWatir::H1.new(self, element) } )
    end

    def h2s
      Collection.new(@driver.findElementsByTagName("h2").map { |element| OperaWatir::H2.new(self, element) } )
    end

    def h3s
      Collection.new(@driver.findElementsByTagName("h3").map { |element| OperaWatir::H3.new(self, element) } )
    end

    def h4s
      Collection.new(@driver.findElementsByTagName("h4").map { |element| OperaWatir::H4.new(self, element) } )
    end

    def h5s
      Collection.new(@driver.findElementsByTagName("h5").map { |element| OperaWatir::H5.new(self, element) } )
    end

    def h6s
      Collection.new(@driver.findElementsByTagName("h6").map { |element| OperaWatir::H6.new(self, element) } )
    end

    def images
      Collection.new(@driver.findElementsByTagName("img").map { |element| OperaWatir::Image.new(self, element) } )
    end

    def inss
      Collection.new(@driver.findElementsByTagName("ins").map { |element| OperaWatir::Ins.new(self, element) } )
    end

    def labels
      Collection.new(@driver.findElementsByTagName("label").map { |element| OperaWatir::Label.new(self, element) } )
    end

    def links
      Collection.new(@driver.findElementsByTagName("a").map { |element| OperaWatir::Link.new(self, element) } )
    end

    def lis
      Collection.new(@driver.findElementsByTagName("li").map { |element| OperaWatir::Li.new(self, element) } )
    end

    def maps
      Collection.new(@driver.findElementsByTagName("map").map { |element| OperaWatir::Map.new(self, element) } )
    end

    def metas
      Collection.new(@driver.findElementsByTagName("meta").map { |element| OperaWatir::Meta.new(self, element) } )
    end

    def ols
      Collection.new(@driver.findElementsByTagName("ol").map { |element| OperaWatir::Ol.new(self, element) } )
    end

    def options
      Collection.new(@driver.findElementsByTagName("option").map { |element| OperaWatir::Option.new(self, element) } )
    end

    def pres
      Collection.new(@driver.findElementsByTagName("pre").map { |element| OperaWatir::Pre.new(self, element) } )
    end

    def ps
      Collection.new(@driver.findElementsByTagName("p").map { |element| OperaWatir::P.new(self, element) } )
    end

    def radios
      Collection.new(@driver.findElementsByTagName("radio").map { |element| OperaWatir::Radio.new(self, element) } )
    end

    def select_lists
      Collection.new(@driver.findElementsByTagName("select").map { |element| OperaWatir::SelectList.new(self, element) } )
    end

    def spans
      Collection.new(@driver.findElementsByTagName("span").map { |element| OperaWatir::Span.new(self, element) } )
    end

    def strongs
      Collection.new(@driver.findElementsByTagName("strong").map { |element| OperaWatir::Strong.new(self, element) } )
    end

    def tbodys
      Collection.new(@driver.findElementsByTagName("tbody").map { |element| OperaWatir::TBody.new(self, element) } )
    end

    def cells
      Collection.new(@driver.findElementsByTagName("td").map { |element| OperaWatir::Td.new(self, element) } )
    end

    def tfoots
      Collection.new(@driver.findElementsByTagName("h1").map { |element| OperaWatir::TFoot.new(self, element) } )
    end

    def theads
      Collection.new(@driver.findElementsByTagName("thead").map { |element| OperaWatir::THead.new(self, element) } )
    end

    def rows
      Collection.new(@driver.findElementsByTagName("tr").map { |element| OperaWatir::Tr.new(self, element) } )
    end

    def tables
      Collection.new(@driver.findElementsByTagName("table").map { |element| OperaWatir::Table.new(self, element) } )
    end

    def text_fields
      Collection.new(@driver.findElementsByTagName("input").map { |element| OperaWatir::H1.new(self, element) } )
    end

    def uls
      Collection.new(@driver.findElementsByTagName("ul").map { |element| OperaWatir::Ul.new(self, element) } )
    end

  private

    class Collection < Array

      def [](index)
        super(index - 1)
      end

    end
  end
end

