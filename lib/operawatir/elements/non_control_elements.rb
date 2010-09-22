module OperaWatir
  class NonControlElement < WebElement
  end

  class Area < NonControlElement
    element_attr_reader :shape, :href
  end

  class Dd < NonControlElement
  end

  class Del < NonControlElement
  end

  class Div < NonControlElement
  end

  class Dl < NonControlElement
  end

  class Dt < NonControlElement
  end

  class Em < NonControlElement
  end

  class H1 < NonControlElement
  end

  class H2 < NonControlElement
  end

  class H3 < NonControlElement
  end

  class H4 < NonControlElement
  end

  class H5 < NonControlElement
  end

  class H6 < NonControlElement
  end

  class Hidden < NonControlElement

    def self.xpath
      'input[@type = "hidden"]'
    end

  end

  class Ins < NonControlElement
  end

  class Label < NonControlElement
    element_attr_reader :for
  end

  class Map < NonControlElement
  end

  class Meta < NonControlElement
  end

  class Ol < NonControlElement
  end

  class Li < NonControlElement
  end

  class Pre < NonControlElement
  end

  class P < NonControlElement
  end

  class Span < NonControlElement
  end

  class Strong < NonControlElement
  end

  class TableBody < NonControlElement
    def self.tag
      :tbody
    end
  end

  class TableCell < NonControlElement
    element_attr_reader :colspan
    
    def self.tag
      :td
    end
  end

  class TFoot < NonControlElement
  end

  class THead < NonControlElement
  end

  class Row < NonControlElement
    def self.tag
      :tr
    end
  end

  class Table < NonControlElement

    def body
      bodies.first
    end

    alias_method :row, :rows

  end

  class Ul < NonControlElement
  end

end
