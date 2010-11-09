require 'forwardable'

class OperaWatir::Collection
  extend Forwardable
  include Enumerable
  
  attr_accessor :selector, :parent

  attr_writer :elements

  def initialize(parent, elements=nil)
    self.selector = OperaWatir::Selector.new(self)
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
    end.map {|e| OperaWatir::Element.new(e)}
  end
  
  def find_by_tag(tag)
    elements.inject([]) do |nodes, element|
      nodes << element.node.findElementsByTagName(tag)
      nodes
    end.map {|e| OperaWatir::Element.new(e)}
  end
  
  def self.refine_by_attributes(elements, attribs)
    
    return [elements[attribs[:index]]] if attribs[:index]
    
    elements.select do |elm|
      attribs.all? do |attrib, value|
        # Hack
        if value.is_a? Regexp
          elm.send(attrib) =~ value
        else
          elm.send(attrib) == value
        end
      end
    end
  end
  
# private
  
  def map_or_return(&blk)
    single? ? blk.call(elements.first) : map(&blk)
  end
  
end
