module OperaWatir
  module Collections

    # @return [Collection<Area>] Finds all descendant +area+ elements
    def areas
      Collection.new(self, Area)
    end

    # @return [Collection<Button>] Finds all descendant +button+ elements
    def buttons
      Collection.new(self, Button)
    end

    # @return [Collection<CheckBox>] Finds all descendant +input[type=checkbox]+ elements
    def checkboxes
      Collection.new(self, CheckBox)
    end

    # @return [Collection<Dd>] Finds all descendant +dd+ elements
    def dds
      Collection.new(self, Dd)
    end

    # @return [Collection<Del>] Finds all descendant +del+ elements
    def dels
      Collection.new(self, Del)
    end

    # @return [Collection<Div>] Finds all descendant +div+ elements
    def divs
      Collection.new(self, Div)
    end

    # @return [Collection<Dl>] Finds all descendant +dl+ elements
    def dls
      Collection.new(self, Dl)
    end

    # @return [Collection<Dt>] Finds all descendant +dt+ elements
    def dts
      Collection.new(self, Dt)
    end

    # @return [Collection<Em>] Finds all descendant +em+ elements
    def ems
      Collection.new(self, Em)
    end

    # @return [Collection<FileField>] Finds all descendant +input[type=file]+ elements
    def file_fields
      Collection.new(self, FileField) {|root| root.findElementsByXPath(FileField.xpath)}
    end

    # @return [Collection<Form>] Finds all descendant +form+ elements
    def forms
      Collection.new(self, Form)
    end

    # @return [Collection<Frame>] Finds all descendant +frame+ elements
    def frames
      Collection.new(self, Frame)
    end

    # @return [Collection<Hidden>] Finds all descendant +input[type=hidden]+ elements
    def hiddens
      Collection.new(self, Hidden) {|root| root.findElementsByXPath(Hidden.xpath)}
    end

    # @return [Collection<H1>] Finds all descendant +h1+ elements
    def h1s
      Collection.new(self, H1)
    end

    # @return [Collection<H2>] Finds all descendant +h2+ elements
    def h2s
      Collection.new(self, H2)
    end

    # @return [Collection<H3>] Finds all descendant +h3+ elements
    def h3s
      Collection.new(self, H3)
    end

    # @return [Collection<H4>] Finds all descendant +h4+ elements
    def h4s
      Collection.new(self, H4)
    end

    # @return [Collection<H5>] Finds all descendant +h5+ elements
    def h5s
      Collection.new(self, H5)
    end

    # @return [Collection<H6>] Finds all descendant +h6+ elements
    def h6s
      Collection.new(self, H6)
    end

    # @return [Collection<Image>] Finds all descendant +img+ elements
    def images
      Collection.new(self, Image)
    end

    # @return [Collection<Ins>] Finds all descendant +ins+ elements
    def inses
      Collection.new(self, Ins)
    end

    # @return [Collection<Label>] Finds all descendant +label+ elements
    def labels
      Collection.new(self, Label)
    end

    # @return [Collection<Link>] Finds all descendant +a+ elements
    def links
      Collection.new(self, Link)
    end

    # @return [Collection<Li>] Finds all descendant +li+ elements
    def lis
      Collection.new(self, Li)
    end

    # @return [Collection<Map>] Finds all descendant +map+ elements
    def maps
      Collection.new(self, Map)
    end

    # @return [Collection<Meta>] Finds all descendant +meta+ elements
    def metas
      Collection.new(self, Meta)
    end

    # @return [Collection<Ol>] Finds all descendant +ol+ elements
    def ols
      Collection.new(self, Ol)
    end

    # @return [Collection<option>] Finds all descendant +option+ elements
    def options
      Collection.new(self, Option)
    end

    # @return [Collection<Pre>] Finds all descendant +pre+ elements
    def pres
      Collection.new(self, Pre)
    end

    # @return [Collection<P>] Finds all descendant +p+ elements
    def ps
      Collection.new(self, P)
    end

    # @return [Collection<Radio>] Finds all descendant +input[type=radio]+ elements
    def radios
      Collection.new(self, Radio)
    end

    # @return [Collection<Select>] Finds all descendant +select+ elements
    def select_lists
      Collection.new(self, SelectList)
    end

    # @return [Collection<Span>] Finds all descendant +span+ elements
    def spans
      Collection.new(self, Span)
    end

    # @return [Collection<Strong>] Finds all descendant +strong+ elements
    def strongs
      Collection.new(self, Strong)
    end

    # @return [Collection<TableBody>] Finds all descendant +tbody+ elements
    def tbodies
      Collection.new(self, TableBody)
    end

    alias_method :bodies, :tbodies

    # @return [Collection<TableCell>] Finds all descendant +td+ elements
    def cells
      Collection.new(self, TableCell)
    end

    # @return [Collection<TableFooter>] Finds all descendant +tfoot+ elements
    def tfoots
      Collection.new(self, TableFooter)
    end

    # @return [Collection<THead>] Finds all descendant +thead+ elements
    def theads
      Collection.new(self, THead)
    end

    # @return [Collection<Row>] Finds all descendant +tr+ elements
    def rows
      Collection.new(self, Row)
    end

    # @return [Collection<Table>] Finds all descendant +table+ elements
    def tables
      Collection.new(self, Table)
    end

    # @return [Collection<TextField>] Finds all descendant +input[type=text]+ elements
    def text_fields
      Collection.new(self, TextField) {|d| d.findElementsByXPath(TextField.xpath)}
    end

    # @return [Collection<UL>] Finds all descendant +ul+ elements
    def uls
      Collection.new(self, UL)
    end

    # Watir Collectins mimic arrays (mostly) however are 1 indexed.
    # When you access an element, #[0] raises an error and #[0] == #first
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

      # Watir Collections are 1 indexed, so #[1] == #first
      #
      # @raise [ArgumentError] if the index is 0 or less.
      # @return [Object] object at 1-indexed position.
      def [](index)
        raise ArgumentError if index < 0
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
