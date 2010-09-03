module OperaWatir
  module Collections

    def areas
      Collection.new(@driver.findElementsByTagName('areas').map {|element| Area.new(self, element)})
    end

    def buttons
      Collection.new(@driver.findElementsByTagName('button').map {|element| Button.new(self, element)})
    end

    def checkboxes
      Collection.new(@driver.findElementsByTagName('checkbox').map {|element| CheckBox.new(self, element)})
    end

    def dds
      Collection.new(@driver.findElementsByTagName('dd').map {|element| Dd.new(self, element)})
    end

    def dels
      Collection.new(@driver.findElementsByTagName('del').map {|element| Del.new(self, element)})
    end

    def divs
      Collection.new(@driver.findElementsByTagName('div').map {|element| Div.new(self, element)})
    end

    def dls
      Collection.new(@driver.findElementsByTagName('dl').map {|element| Dl.new(self, element)})
    end

    def dts
      Collection.new(@driver.findElementsByTagName('dt').map {|element| Dt.new(self, element)})
    end

    def elements
      raise 'TODO'
    end

    def ems
      Collection.new(@driver.findElementsByTagName('em').map {|element| Em.new(self, element)})
    end

    def file_fields
      Collection.new(@driver.findElementsByTagName('input[type=file]').map {|element| FileField.new(self, element)})
    end

    def forms
      Collection.new(@driver.findElementsByTagName('form').map {|element| Form.new(self, element)})
    end

    def frames
      Collection.new(@driver.findElementsByTagName('frame').map {|element| Frame.new(self, element)})
    end

    def hiddens
      Collection.new(@driver.findElementsByTagName('input[type=hidden]').map {|element| Hidden.new(self, element)})
    end

    def h1s
      Collection.new(@driver.findElementsByTagName('h1').map {|element| H1.new(self, element)})
    end

    def h2s
      Collection.new(@driver.findElementsByTagName('h2').map {|element| H2.new(self, element)})
    end

    def h3s
      Collection.new(@driver.findElementsByTagName('h3').map {|element| H3.new(self, element)})
    end

    def h4s
      Collection.new(@driver.findElementsByTagName('h4').map {|element| H4.new(self, element)})
    end

    def h5s
      Collection.new(@driver.findElementsByTagName('h5').map {|element| H5.new(self, element)})
    end

    def h6s
      Collection.new(@driver.findElementsByTagName('h6').map {|element| H6.new(self, element)})
    end

    def images
      Collection.new(@driver.findElementsByTagName('img').map {|element| Image.new(self, element)})
    end

    def inss
      Collection.new(@driver.findElementsByTagName('ins').map {|element| Ins.new(self, element)})
    end

    def labels
      Collection.new(@driver.findElementsByTagName('label').map {|element| Label.new(self, element)})
    end

    def links
      Collection.new(@driver.findElementsByTagName('a').map {|element| Link.new(self, element)})
    end

    def lis
      Collection.new(@driver.findElementsByTagName('li').map {|element| Li.new(self, element)})
    end

    def maps
      Collection.new(@driver.findElementsByTagName('map').map {|element| Map.new(self, element)})
    end

    def metas
      Collection.new(@driver.findElementsByTagName('meta').map {|element| Meta.new(self, element)})
    end

    def ols
      Collection.new(@driver.findElementsByTagName('ol').map {|element| Ol.new(self, element)})
    end

    def options
      Collection.new(@driver.findElementsByTagName('option').map {|element| Option.new(self, element)})
    end

    def pres
      Collection.new(@driver.findElementsByTagName('pre').map {|element| Pre.new(self, element)})
    end

    def ps
      Collection.new(@driver.findElementsByTagName('p').map {|element| P.new(self, element)})
    end

    def radios
      Collection.new(@driver.findElementsByTagName('radio').map {|element| Radio.new(self, element)})
    end

    def select_lists
      Collection.new(@driver.findElementsByTagName('select').map {|element| SelectList.new(self, element)})
    end

    def spans
      Collection.new(@driver.findElementsByTagName('span').map {|element| Span.new(self, element)})
    end

    def strongs
      Collection.new(@driver.findElementsByTagName('strong').map {|element| Strong.new(self, element)})
    end

    def tbodys
      Collection.new(@driver.findElementsByTagName('tbody').map {|element| TBody.new(self, element)})
    end

    def cells
      Collection.new(@driver.findElementsByTagName('td').map {|element| Td.new(self, element)})
    end

    def tfoots
      Collection.new(@driver.findElementsByTagName('h1').map {|element| TFoot.new(self, element)})
    end

    def theads
      Collection.new(@driver.findElementsByTagName('thead').map {|element| THead.new(self, element)})
    end

    def rows
      Collection.new(@driver.findElementsByTagName('tr').map {|element| Tr.new(self, element)})
    end

    def tables
      Collection.new(@driver.findElementsByTagName('table').map {|element| Table.new(self, element)})
    end

    def text_fields
      Collection.new(@driver.findElementsByTagName('input').map {|element| H1.new(self, element)})
    end

    def uls
      Collection.new(@driver.findElementsByTagName('ul').map {|element| Ul.new(self, element)})
    end

  private

    class Collection

      def [](index)
        super(index + 1)
      end

    end

  end
end
