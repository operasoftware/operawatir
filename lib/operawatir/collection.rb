require 'forwardable'

class OperaWatir::Collection
  extend Forwardable
  include Enumerable

  attr_accessor :selectors, :parent

  def initialize(parent)
    self.parent, self.selectors = parent, []
  end

  def add_selector(type, value)
    self.selectors << OperaWatir::Selector.new(self, type, value)
  end

  def add_selector_from_arguments(args)
    add_selector :attribute, args.first
  end

  def exist?
    !_elms.empty?
  rescue OperaWatir::Exceptions::UnknownObjectException
    false
  end
  alias_method :exists?, :exist? # LOL Ruby

  def single?
    _elms.length == 1
  end

  def_delegators :_elms, :each, :length, :size, :[], :first, :last, :empty?

  # Proxy for find_elements_by_id, find_elements_by_tag etc.
  OperaWatir::Selector::BASIC_TYPES.each do |type|
    define_method("find_elements_by_#{type}") do |value|
      _elms.inject([]) do |col, element|
        col | element.send("find_elements_by_#{type}", value)
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

  # Public interface to elms, used in Selector
  def raw_elements
    _elms
  end

private

  # This is the meat and bones of Watir2
  def _elms
    @_elms ||= selectors.inject(nil) do |elms, selector|
      selector.apply_to(elms)
    end
  end

  def map_or_return(&blk)
    single? ? blk.call(_elms.first) : map(&blk)
  end

end
