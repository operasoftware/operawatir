module OperaWatir
  # @private
  class NonControlElement < WebElement
  end

  # Class for +area+ elements
  class Area < NonControlElement
    element_attr_reader :shape, :href
  end

  # Class for +dd+ elements
  class Dd < NonControlElement
  end

  # Class for +del+ elements
  class Del < NonControlElement
  end

  # Class for +div+ elements
  class Div < NonControlElement
  end

  # Class for +dl+ elements
  class Dl < NonControlElement
  end

  # Class for +dt+ elements
  class Dt < NonControlElement
  end

  # Class for +em+ elements
  class Em < NonControlElement
  end

  # Class for +h1+ elements
  class H1 < NonControlElement
  end

  # Class for +h2+ elements
  class H2 < NonControlElement
  end

  # Class for +h3+ elements
  class H3 < NonControlElement
  end

  # Class for +h4+ elements
  class H4 < NonControlElement
  end

  # Class for +h5+ elements
  class H5 < NonControlElement
  end

  # Class for +h6+ elements
  class H6 < NonControlElement
  end

  # Class for +input[type=hidden]+ elements
  class Hidden < NonControlElement
  private
    def self.xpath
      'input[@type = "hidden"]'
    end
  end

  # Class for +ins+ elements
  class Ins < NonControlElement
  end

  # Class for +label+ elements
  class Label < NonControlElement
    element_attr_reader :for
  end

  # Class for +map+ elements
  class Map < NonControlElement
  end

  # Class for +meta+ elements
  class Meta < NonControlElement
  end

  # Class for +ol+ elements
  class Ol < NonControlElement
  end

  # Class for +li+ elements
  class Li < NonControlElement
  end

  # Class for +pre+ elements
  class Pre < NonControlElement
  end

  # Class for +p+ elements
  class P < NonControlElement
  end

  # Class for +span+ elements
  class Span < NonControlElement
  end

  # Class for +strong+ elements
  class Strong < NonControlElement
  end

  # Class for +tbody+ elements
  class TableBody < NonControlElement
    # @return [:tbody] the html tag of the element
    def self.tag
      :tbody
    end
  end

  # Class for +td+ elements
  class TableCell < NonControlElement
    element_attr_reader :colspan
    # @return [:tag] the html tag of the element
    def self.tag
      :td
    end
  end

  # Class for +tfoot+ elements
  class TableFooter < NonControlElement
  end

  # Class for +thead+ elements
  class TableHeader < NonControlElement
  end

  # Class for +tr+ elements
  class Row < NonControlElement
    # @return [:tr] the html tag of the element
    def self.tag
      :tr
    end
  end

  # Class for +table+ elements
  class Table < NonControlElement
    # @return the table's body
    def body
      bodies.first
    end

    alias_method :row, :rows
  end

  # Class for +ul+ elements
  class Ul < NonControlElement
  end

end
