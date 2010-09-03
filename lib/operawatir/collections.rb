module OperaWatir
  module Collections

    def areas
      @driver.getElementsByTagName('areas').map {|element| Area.new(self, element)}
    end

    def buttons
      @driver.getElementsByTagName('button').map {|element| Button.new(self, element)}
    end

    def checkboxes
      @driver.getElementsByTagName('checkbox').map {|element| CheckBox.new(self, element)}
    end

    def dds
      @driver.getElementsByTagName('dd').map {|element| Dd.new(self, element)}
    end

    def dels
      @driver.getElementsByTagName('del').map {|element| Del.new(self, element)}
    end

    def divs
      @driver.getElementsByTagName('div').map {|element| Div.new(self, element)}
    end

    def dls
      @driver.getElementsByTagName('dl').map {|element| Dl.new(self, element)}
    end

    def dts
      @driver.getElementsByTagName('dt').map {|element| Dt.new(self, element)}
    end

    def elements
      raise 'TODO'
    end

    def ems
      @driver.getElementsByTagName('em').map {|element| Em.new(self, element)}
    end

    def file_fields
      @driver.getElementsByTagName('input[type=file]').map {|element| FileField.new(self, element)}
    end

    def forms
      @driver.getElementsByTagName('form').map {|element| Form.new(self, element)}
    end

    def frames
      @driver.getElementsByTagName('frame').map {|element| Frame.new(self, element)}
    end

    def hiddens
      @driver.getElementsByTagName('input[type=hidden]').map {|element| Hidden.new(self, element)}
    end

    def h1s
      @driver.getElementsByTagName('h1').map {|element| H1.new(self, element)}
    end

    def h2s
      @driver.getElementsByTagName('h2').map {|element| H2.new(self, element)}
    end

    def h3s
      @driver.getElementsByTagName('h3').map {|element| H3.new(self, element)}
    end

    def h4s
      @driver.getElementsByTagName('h4').map {|element| H4.new(self, element)}
    end

    def h5s
      @driver.getElementsByTagName('h5').map {|element| H5.new(self, element)}
    end

    def h6s
      @driver.getElementsByTagName('h6').map {|element| H6.new(self, element)}
    end

    def images
      @driver.getElementsByTagName('img').map {|element| Image.new(self, element)}
    end

    def inss
      @driver.getElementsByTagName('ins').map {|element| Ins.new(self, element)}
    end

    def labels
      @driver.getElementsByTagName('label').map {|element| Label.new(self, element)}
    end

    def links
      @driver.getElementsByTagName('a').map {|element| Link.new(self, element)}
    end

    def lis
      @driver.getElementsByTagName('li').map {|element| Li.new(self, element)}
    end

    def maps
      @driver.getElementsByTagName('map').map {|element| Map.new(self, element)}
    end

    def metas
      @driver.getElementsByTagName('meta').map {|element| Meta.new(self, element)}
    end

    def ols
      @driver.getElementsByTagName('ol').map {|element| Ol.new(self, element)}
    end

    def options
      @driver.getElementsByTagName('option').map {|element| Option.new(self, element)}
    end

    def pres
      @driver.getElementsByTagName('pre').map {|element| Pre.new(self, element)}
    end

    def ps
      @driver.getElementsByTagName('p').map {|element| P.new(self, element)}
    end

    def radios
      @driver.getElementsByTagName('radio').map {|element| Radio.new(self, element)}
    end

    def select_lists
      @driver.getElementsByTagName('select').map {|element| SelectList.new(self, element)}
    end

    def spans
      @driver.getElementsByTagName('span').map {|element| Span.new(self, element)}
    end

    def strongs
      @driver.getElementsByTagName('strong').map {|element| Strong.new(self, element)}
    end

    def tbodys
      @driver.getElementsByTagName('tbody').map {|element| TBody.new(self, element)}
    end

    def cells
      @driver.getElementsByTagName('td').map {|element| Td.new(self, element)}
    end

    def tfoots
      @driver.getElementsByTagName('h1').map {|element| TFoot.new(self, element)}
    end

    def theads
      @driver.getElementsByTagName('thead').map {|element| THead.new(self, element)}
    end

    def rows
      @driver.getElementsByTagName('tr').map {|element| Tr.new(self, element)}
    end

    def tables
      @driver.getElementsByTagName('table').map {|element| Table.new(self, element)}
    end

    def text_fields
      @driver.getElementsByTagName('input').map {|element| H1.new(self, element)}
    end

    def uls
      @driver.getElementsByTagName('ul').map {|element| Ul.new(self, element)}
    end

  end
end
