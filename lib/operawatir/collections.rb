module OperaWatir
  module Collections

    def areas
      Collection.new(self, OperaWatir::Area) {|d| d.findElementsByTagName('area')}
    end

    def buttons
      Collection.new(self, OperaWatir::Button) {|d| d.findElementsByTagName('button')}
    end

    def checkboxes
      Collection.new(self, OperaWatir::CheckBox) {|d| d.findElementsByTagName('checkbox')}
    end

    def dds
      Collection.new(self, OperaWatir::DD) {|d| d.findElementsByTagName('dd')}
    end

    def dels
      Collection.new(self, OperaWatir::Del) {|d| d.findElementsByTagName('del')}
    end

    def divs
      Collection.new(self, OperaWatir::Div) {|d| d.findElementsByTagName('div')}
    end

    def dls
      Collection.new(self, OperaWatir::Dl) {|d| d.findElementsByTagName('dl')}
    end

    def dts
      Collection.new(self, OperaWatir::Dt) {|d| d.findElementsByTagName('dt')}
    end

    def ems
      Collection.new(self, OperaWatir::Em) {|d| d.findElementsByTagName('em')}
    end

    def file_fields
      Collection.new(self, OperaWatir::FileField) {|d| d.findElementsByCssSelector('input[type=file]')}
    end

    def forms
      Collection.new(self, OperaWatir::Form) {|d| d.findElementsByTagName('form')}
    end

    def frames
      Collection.new(self, OperaWatir::Frame) {|d| d.findElementsByTagName('frame')}
    end

    def hiddens
      Collection.new(self, OperaWatir::Hidden) {|d| d.findElementsByCssSelector('input[type=hidden]')}
    end

    def h1s
      Collection.new(self, OperaWatir::H1) {|d| d.findElementsByTagName('h1')}
    end

    def h2s
      Collection.new(self, OperaWatir::H2) {|d| d.findElementsByTagName('h2')}
    end

    def h3s
      Collection.new(self, OperaWatir::H3) {|d| d.findElementsByTagName('h3')}
    end

    def h4s
      Collection.new(self, OperaWatir::H4) {|d| d.findElementsByTagName('h4')}
    end

    def h5s
      Collection.new(self, OperaWatir::H5) {|d| d.findElementsByTagName('h5')}
    end

    def h6s
      Collection.new(self, OperaWatir::H6) {|d| d.findElementsByTagName('h6')}
    end

    def images
      Collection.new(self, OperaWatir::Image) {|d| d.findElementsByTagName('img')}
    end

    def inss
      Collection.new(self, OperaWatir::Ins) {|d| d.findElementsByTagName('ins')}
    end

    def labels
      Collection.new(self, OperaWatir::Label) {|d| d.findElementsByTagName('label')}
    end

    def links
      Collection.new(self, OperaWatir::Link) {|d| d.findElementsByTagName('a')}
    end

    def lis
      Collection.new(self, OperaWatir::Li) {|d| d.findElementsByTagName('li')}
    end

    def maps
      Collection.new(self, OperaWatir::Map) {|d| d.findElementsByTagName('map')}
    end

    def metas
      Collection.new(self, OperaWatir::Meta) {|d| d.findElementsByTagName('meta')}
    end

    def ols
      Collection.new(self, OperaWatir::Ol) {|d| d.findElementsByTagName('ol')}
    end

    def options
      Collection.new(self, OperaWatir::Option) {|d| d.findElementsByTagName('option')}
    end

    def pres
      Collection.new(self, OperaWatir::Pre) {|d| d.findElementsByTagName('pre')}
    end

    def ps
      Collection.new(self, OperaWatir::P) {|d| d.findElementsByTagName('p')}
    end

    def radios
      Collection.new(self, OperaWatir::Radio) {|d| d.findElementsByTagName('radio')}
    end

    def select_lists
      Collection.new(self, OperaWatir::SelectList) {|d| d.findElementsByTagName('select')}
    end

    def spans
      Collection.new(self, OperaWatir::Span) {|d| d.findElementsByTagName('span')}
    end

    def strongs
      Collection.new(self, OperaWatir::Strong) {|d| d.findElementsByTagName('strong')}
    end

    def tbodys
      Collection.new(self, OperaWatir::TBody) {|d| d.findElementsByTagName('tbody')}
    end

    def cells
      Collection.new(self, OperaWatir::Td) {|d| d.findElementsByTagName('td')}
    end

    def tfoots
      Collection.new(self, OperaWatir::TFoot) {|d| d.findElementsByTagName('tfoot')}
    end

    def theads
      Collection.new(self, OperaWatir::THead) {|d| d.findElementsByTagName('thead')}
    end

    def rows
      Collection.new(@driver.findElementsByTagName('tr').map {|element| OperaWatir::Tr.new_with_element(self, element)})
    end

    def tables
      Collection.new(self, OperaWatir::Table) {|d| d.findElementsByTagName('table')}
    end

    def text_fields
      Collection.new(self, OperaWatir::TextField) {|d| d.findElementsByTagName('input')}
    end

    def uls
      Collection.new(self, OperaWatir::UL) {|d| d.findElementsByTagName('ul')}
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
        @elements
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
