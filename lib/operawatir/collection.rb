class OperaWatir::Collection
  extend Forwardable
  include Enumerable
  
  attr_accessor :selectors, :parent

  def initialize(parent)
    self.parent, self.selectors = parent, []
  end
  
  # TODO Refactor
  def add_selector(method, value)
    selectors << OperaWatir::Selector.new(method, value)
  end

  def elements
    @elements ||= selectors.inject(parent.elements) do |elms, selector|
      selector.find(elms || parent)
    end
  end
  
  def exist?
    !elements.empty?
  rescue OperaWatir::Exceptions::UnknownObjectException
    false
  end
  
  alias_method :exists?, :exist?

  def singular?
    elements.size < 2
  end
  
  def_delegators :elements, :each, :length, :[]

  # No call to super. OperaWatir collections are completely transparent.
  def method_missing(method, *args, &blk)
    map_or_return {|elm| elm.send(method, *args, &blk) }
  end
  
  def id
    map_or_return {|elm| elm.id}
  end
  
private
  
  def map_or_return(&blk)
    singular? ? blk.call(elements.first) : map(&blk)
  end
  
end
