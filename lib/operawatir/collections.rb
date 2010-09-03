module OperaWatir
  module Collections

    def areas
      @driver.findElementsByTagName('areas').map {|element| Area.new(self, element)}
    end

    def buttons
      @driver.findElementsByTagName('button').map {|element| Button.new(self, element)}
    end

    def checkboxes
      @driver.findElementsByTagName('checkbox').map {|element| CheckBox.new(self, element)}
    end

    def dds
      @driver.findElementsByTagName('dd').map {|element| Dd.new(self, element)}
    end

    def dels
      @driver.findElementsByTagName('del').map {|element| Del.new(self, element)}
    end

    def divs
      @driver.findElementsByTagName('div').map {|element| Div.new(self, element)}
    end

    def dls
      @driver.findElementsByTagName('dl').map {|element| Dl.new(self, element)}
    end

    def dts
      @driver.findElementsByTagName('dt').map {|element| Dt.new(self, element)}
    end

    def elements
      raise 'TODO'
    end

    def ems
      @driver.findElementsByTagName('em').map {|element| Em.new(self, element)}
    end

    def file_fields
      @driver.findElementsByTagName('input[type=file]').map {|element| FileField.new(self, element)}
    end

    def forms
      @driver.findElementsByTagName('form').map {|element| Form.new(self, element)}
    end

    def frames
      @driver.findElementsByTagName('frame').map {|element| Frame.new(self, element)}
    end

    def hiddens
      @driver.findElementsByTagName('input[type=hidden]').map {|element| Hidden.new(self, element)}
    end

    def h1s
      @driver.findElementsByTagName('h1').map {|element| H1.new(self, element)}
    end

    def h2s
      @driver.findElementsByTagName('h2').map {|element| H2.new(self, element)}
    end

    def h3s
      @driver.findElementsByTagName('h3').map {|element| H3.new(self, element)}
    end

    def h4s
      @driver.findElementsByTagName('h4').map {|element| H4.new(self, element)}
    end

    def h5s
      @driver.findElementsByTagName('h5').map {|element| H5.new(self, element)}
    end

    def h6s
      @driver.findElementsByTagName('h6').map {|element| H6.new(self, element)}
    end

    def images
      @driver.findElementsByTagName('img').map {|element| Image.new(self, element)}
    end

    def inss
      @driver.findElementsByTagName('ins').map {|element| Ins.new(self, element)}
    end

    def labels
      @driver.findElementsByTagName('label').map {|element| Label.new(self, element)}
    end

    def links
      @driver.findElementsByTagName('a').map {|element| Link.new(self, element)}
    end

    def lis
      @driver.findElementsByTagName('li').map {|element| Li.new(self, element)}
    end

    def maps
      @driver.findElementsByTagName('map').map {|element| Map.new(self, element)}
    end

    def metas
      @driver.findElementsByTagName('meta').map {|element| Meta.new(self, element)}
    end

    def ols
      @driver.findElementsByTagName('ol').map {|element| Ol.new(self, element)}
    end

    def options
      @driver.findElementsByTagName('option').map {|element| Option.new(self, element)}
    end

    def pres
      @driver.findElementsByTagName('pre').map {|element| Pre.new(self, element)}
    end

    def ps
      @driver.findElementsByTagName('p').map {|element| P.new(self, element)}
    end

    def radios
      @driver.findElementsByTagName('radio').map {|element| Radio.new(self, element)}
    end

    def select_lists
      @driver.findElementsByTagName('select').map {|element| SelectList.new(self, element)}
    end

    def spans
      @driver.findElementsByTagName('span').map {|element| Span.new(self, element)}
    end

    def strongs
      @driver.findElementsByTagName('strong').map {|element| Strong.new(self, element)}
    end

    def tbodys
      @driver.findElementsByTagName('tbody').map {|element| TBody.new(self, element)}
    end

    def cells
      @driver.findElementsByTagName('td').map {|element| Td.new(self, element)}
    end

    def tfoots
      @driver.findElementsByTagName('h1').map {|element| TFoot.new(self, element)}
    end

    def theads
      @driver.findElementsByTagName('thead').map {|element| THead.new(self, element)}
    end

    def rows
      @driver.findElementsByTagName('tr').map {|element| Tr.new(self, element)}
    end

    def tables
      @driver.findElementsByTagName('table').map {|element| Table.new(self, element)}
    end

    def text_fields
      @driver.findElementsByTagName('input').map {|element| H1.new(self, element)}
    end

    def uls
      @driver.findElementsByTagName('ul').map {|element| Ul.new(self, element)}
    end

  end
end
