module OperaWatir
  module Collections

    def areas
      Collection.new(self, Area) {|d| d.findElementsByTagName('area')}
    end

    def buttons
      Collection.new(self, Button) {|d| d.findElementsByTagName('button')}
    end

    def checkboxes
      Collection.new(self, CheckBox) {|d| d.findElementsByTagName('checkbox')}
    end

    def dds
      Collection.new(self, DD) {|d| d.findElementsByTagName('dd')}
    end

    def dels
      Collection.new(self, Del) {|d| d.findElementsByTagName('del')}
    end

    def divs
      Collection.new(self, Div) {|d| d.findElementsByTagName('div')}
    end

    def dls
      Collection.new(self, Dl) {|d| d.findElementsByTagName('dl')}
    end

    def dts
      Collection.new(self, Dt) {|d| d.findElementsByTagName('dt')}
    end

    def ems
      Collection.new(self, Em) {|d| d.findElementsByTagName('em')}
    end

    def file_fields
      Collection.new(self, FileField) {|d| d.findElementsByCssSelector('input[type=file]')}
    end

    def forms
      Collection.new(self, Form) {|d| d.findElementsByTagName('form')}
    end

    def frames
      Collection.new(self, Frame) {|d| d.findElementsByTagName('frame')}
    end

    def hiddens
      Collection.new(self, Hidden) {|d| d.findElementsByCssSelector('input[type=hidden]')}
    end

    def h1s
      Collection.new(self, H1) {|d| d.findElementsByTagName('h1')}
    end

    def h2s
      Collection.new(self, H2) {|d| d.findElementsByTagName('h2')}
    end

    def h3s
      Collection.new(self, H3) {|d| d.findElementsByTagName('h3')}
    end

    def h4s
      Collection.new(self, H4) {|d| d.findElementsByTagName('h4')}
    end

    def h5s
      Collection.new(self, H5) {|d| d.findElementsByTagName('h5')}
    end

    def h6s
      Collection.new(self, H6) {|d| d.findElementsByTagName('h6')}
    end

    def images
      Collection.new(self, Image) {|d| d.findElementsByTagName('img')}
    end

    def inss
      Collection.new(self, Ins) {|d| d.findElementsByTagName('ins')}
    end

    def labels
      Collection.new(self, Label) {|d| d.findElementsByTagName('label')}
    end

    def links
      Collection.new(self, Link) {|d| d.findElementsByTagName('a')}
    end

    def lis
      Collection.new(self, Li) {|d| d.findElementsByTagName('li')}
    end

    def maps
      Collection.new(self, Map) {|d| d.findElementsByTagName('map')}
    end

    def metas
      Collection.new(self, Meta) {|d| d.findElementsByTagName('meta')}
    end

    def ols
      Collection.new(self, Ol) {|d| d.findElementsByTagName('ol')}
    end

    def options
      Collection.new(self, Option) {|d| d.findElementsByTagName('option')}
    end

    def pres
      Collection.new(self, Pre) {|d| d.findElementsByTagName('pre')}
    end

    def ps
      Collection.new(self, P) {|d| d.findElementsByTagName('p')}
    end

    def radios
      Collection.new(self, Radio) {|d| d.findElementsByTagName('radio')}
    end

    def select_lists
      Collection.new(self, SelectList) {|d| d.findElementsByTagName('select')}
    end

    def spans
      Collection.new(self, Span) {|d| d.findElementsByTagName('span')}
    end

    def strongs
      Collection.new(self, Strong) {|d| d.findElementsByTagName('strong')}
    end

    def tbodys
      Collection.new(self, TBody) {|d| d.findElementsByTagName('tbody')}
    end

    def cells
      Collection.new(self, Td) {|d| d.findElementsByTagName('td')}
    end

    def tfoots
      Collection.new(self, TFoot) {|d| d.findElementsByTagName('tfoot')}
    end

    def theads
      Collection.new(self, THead) {|d| d.findElementsByTagName('thead')}
    end

    def rows
      Collection.new(@driver.findElementsByTagName('tr').map {|element| OperaWatir::Tr.new_with_element(self, element)})
    end

    def tables
      Collection.new(self, Table) {|d| d.findElementsByTagName('table')}
    end

    def text_fields
      Collection.new(self, TextField) {|d| d.findElementsByTagName('input')}
    end

    def uls
      Collection.new(self, UL) {|d| d.findElementsByTagName('ul')}
    end

  private

    class Collection
      include Enumerable

      attr_accessor :root, :klass

      def initialize(root, klass)
        self.root, self.klass = root, klass

        @elements = yield(root.element).map {|element| klass.new_with_element(root.element, element)}
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

    end

  end
end
