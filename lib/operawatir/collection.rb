require 'forwardable'

class OperaWatir::Collection
  extend Forwardable
  include Enumerable
  
  attr_accessor :selector, :parent

  attr_writer :elements

  def initialize(parent, elements=nil)
    self.selector = OperaWatir::Selector.new
    self.parent, self.elements = parent, elements
  end

  def elements
    @elements ||= selector.apply(parent)
  end
  
  
  def exist?
    !elements.empty?
  rescue OperaWatir::Exceptions::UnknownObjectException
    false
  end
  
  alias_method :exists?, :exist?

  def single?
    elements.size == 1
  end
  
  def_delegators :elements, :each, :length, :[], :empty?

  # No call to super. OperaWatir collections are completely transparent.
  def method_missing(method, *args, &blk)
    warn "[MISSING] #{self.class} missing #{method}"
    map_or_return {|elm| elm.send(method, *args, &blk) }
  end
                                  
  def id
    map_or_return {|elm| elm.id}
  end
  
  
  def find_by_id(id)
    elements.inject([]) do |nodes, element|
      nodes << element.node.findElementsById(id)
      nodes
    end
  end
  
  def find_by_class(klass)
    driver.findElementsByClassName(klass).to_a.map do |node|
      OperaWatir::Element.new(node)
    end
  end
  
  def find_by_tag(tag)
    driver.findElementsByTagName(tag).to_a.map do |node|
      OperaWatir::Element.new(node)
    end
  end
  
  def find_by_css(css)
    driver.findElementsByCssSelector(css).to_a.map do |node|
      OperaWatir::Element.new(node)
    end
  end
  
  def find_by_xpath(xpath)
    driver.findElementsByXpath(xpath).to_a.map do |node|
      OperaWatir::Element.new(node)
    end
  end
  
  def find_by_attribs(attribs)
    elements.select do |elm|
      attribs.all? do |attrib, value|
        elm.send(attrib) == value
      end
    end
  end
  
# private
  
  def map_or_return(&blk)
    single? ? blk.call(elements.first) : map(&blk)
  end
  
end
