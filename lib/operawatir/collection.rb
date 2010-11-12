require 'forwardable'

class OperaWatir::Collection
  extend Forwardable
  include Enumerable
  
  attr_accessor :selectors, :parent

  attr_writer :elements

  def initialize(parent)
    self.parent, self.selectors = parent, []
  end
  
  # This is the meat and bones of Watir2
  def elements
    @elements ||= selectors.inject(nil) do |elms, selector|
      selector.apply_to(elms)
    end
  end
  
  def add_selector(type, value)
    self.selectors << OperaWatir::Selector.new(self, type, value)
  end
  
  def exist?
    !elements.empty?
  rescue OperaWatir::Exceptions::UnknownObjectException
    false
  end
  alias_method :exists?, :exist?

  def single?
    elements.length == 1
  end
  
  def_delegators :elements, :each, :length, :[], :empty?
  
  def [](index)
    OperaWatir::Collection.new(self).tap do |c|
      c.add_selector :index, index
    end
  end
  
  def first
    OperaWatir::Collection.new(self).tap do |c|
      c.add_selector :index, 0
    end
  end
  
  def last
    OperaWatir::Collection.new(self).tap do |c|
      c.add_selector :index, elements.length - 1
    end
  end
  
  OperaWatir::Selector::BASIC_TYPES.each do |type|
    define_method("find_elements_by_#{type}") do |value|
      elements.inject([]) do |elms, element|
        elms | element.send("find_elements_by_#{type}", value)
      end
    end
  end
  
  
  # No call to super. Collections are completely opaque proxies.
  def method_missing(method, *args, &blk)
    map_or_return {|elm| elm.send(method, *args, &blk) }
  end
  
  def id
    map_or_return {|elm| elm.id}
  end
  
# private
  
  def map_or_return(&blk)
    single? ? blk.call(elements.first) : map(&blk)
  end
  
end
