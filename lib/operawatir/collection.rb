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
  # def method_missing(method, *args, &blk)
  #   warn "[MISSING] #{self.class} missing #{method}"
  #   map_or_return {|elm| elm.send(method, *args, &blk) }
  # end
                                  
  def id
    map_or_return {|elm| elm.id}
  end
  
  def add_selector(type, value)
    self.selectors << OperaWatir::Selector.new(self, type, value)
  end
  
# private
  
  def map_or_return(&blk)
    single? ? blk.call(elements.first) : map(&blk)
  end
  
end
