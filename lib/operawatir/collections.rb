module OperaWatir
  module Collections

    def areas
      Collection.new(self, Area)
    end

    def buttons
      Collection.new(self, Button)
    end

    def checkboxes
      Collection.new(self, CheckBox)
    end

    def dds
      Collection.new(self, Dd)
    end

    def dels
      Collection.new(self, Del)
    end

    def divs
      Collection.new(self, Div)
    end

    def dls
      Collection.new(self, Dl)
    end

    def dts
      Collection.new(self, Dt)
    end

    def ems
      Collection.new(self, Em)
    end

    def file_fields
      Collection.new(self, FileField) {|root| root.findElementsByXPath(FileField.xpath)}
    end

    def forms
      Collection.new(self, Form)
    end

    def frames
      Collection.new(self, Frame)
    end

    def hiddens
      Collection.new(self, Hidden) {|root| root.findElementsByXPath(Hidden.xpath)}
    end

    def h1s
      Collection.new(self, H1)
    end

    def h2s
      Collection.new(self, H2)
    end

    def h3s
      Collection.new(self, H3)
    end

    def h4s
      Collection.new(self, H4)
    end

    def h5s
      Collection.new(self, H5)
    end

    def h6s
      Collection.new(self, H6)
    end

    def images
      Collection.new(self, Image)
    end

    def inses
      Collection.new(self, Ins)
    end

    def labels
      Collection.new(self, Label)
    end

    def links
      Collection.new(self, Link)
    end

    def lis
      Collection.new(self, Li)
    end

    def maps
      Collection.new(self, Map)
    end

    def metas
      Collection.new(self, Meta)
    end

    def ols
      Collection.new(self, Ol)
    end

    def options
      Collection.new(self, Option)
    end

    def pres
      Collection.new(self, Pre)
    end

    def ps
      Collection.new(self, P)
    end

    def radios
      Collection.new(self, Radio)
    end

    def select_lists
      Collection.new(self, SelectList)
    end

    def spans
      Collection.new(self, Span)
    end

    def strongs
      Collection.new(self, Strong)
    end

    def tbodies
      Collection.new(self, TableBody)
    end

    alias_method :bodies, :tbodies

    def cells
      Collection.new(self, TableCell)
    end

    def tfoots
      Collection.new(self, TFoot)
    end

    def theads
      Collection.new(self, THead)
    end

    def rows
      Collection.new(self, Row)
    end

    def tables
      Collection.new(self, Table)
    end

    def text_fields
      Collection.new(self, TextField) {|d| d.findElementsByXPath(TextField.xpath)}
    end

    def uls
      Collection.new(self, UL)
    end

  private

    # Watir Collectins are 1 indexed.

    class Collection
      include Enumerable

      attr_accessor :root, :klass

      def initialize(root, klass, &blk)
        self.root, self.klass = root, klass

        @elements = (block_given? ? blk : default_finder).
          call(root.element).
          map {|element| klass.new_with_element(root.element, element)}
      end

      def length
        @elements.length
      end
      alias_method :size, :length

      def each
        @elements.each {|elm| yield elm}
      end

      def <=>(other)
        index <=> other.index
      end

      def [](index)
        @elements[index - 1]
      end

      def first
        @elements.first
      end

      def last
        @elements.last
      end

      def default_finder
        lambda {|root| root.findElementsByTagName(klass.tag)}
      end

    end

  end
end
