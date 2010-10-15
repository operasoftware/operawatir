class OperaWatir::Collection
  include Enumerable
  
  attr_accessor :selectors, :parent

  def initialize(parent)
    self.parent, self.selectors = parent, []
  end
  
  # TODO Refactor
  def add_selector(method, value)
    selectors << Selector.new(method, value)
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
  
  def each(&blk)
    elements.each(&blk)
  end
  
  # TODO Turn into method_missing
  def id
    map_or_return {|elm| elm.id}
  end
  
private
  
  # TODO Refactor?
  def map_or_return(&blk)
    if singular?
      blk.call(elements.first)
    else
      map(&blk)
    end
  end
  
end
