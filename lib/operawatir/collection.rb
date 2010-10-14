class OperaWatir::Collection
  include Enumerable
  
  attr_accessor :selectors, :parent

  def initialize(parent)
    self.parent, self.selectors = parent, []
  end
  
  # TODO Refactor
  def add_selector(method, value)
    selectors << Selector.new(method, :==, value)
  end

  def elements
    @elements ||= selectors.inject(parent.elements) do |elms, selector|
      if elms.nil?
        selector.find(parent)
      else
        selector.refine(elms)
      end
    end
  end
  
  def exist?
    !elements.empty?
  end
  
  def id
    map_or_return {|elm| elm.id}
  end

  def singular?
    elements.size < 2
  end
  
  def each(&blk)
    elements.each(&blk)
  end
  
private
  
  def map_or_return(&blk)
    if singular?
      blk.call(elements.first)
    else
      map(&blk)
    end
  end
  
end
