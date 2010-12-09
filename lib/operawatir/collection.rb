require 'forwardable'
require 'set'

class OperaWatir::Collection
  extend Forwardable
  include Enumerable

  attr_accessor :parent, :selector

  def initialize(parent, elms=nil)
    self.parent, self.selector = parent, OperaWatir::Selector.new(self)
    @_elms = elms
  end

  def add_selector_from_arguments(args)
    selector.attribute args.first
  end

  def exist?
    !raw_elements.empty?
  rescue OperaWatir::Exceptions::UnknownObjectException
    false
  end
  alias_method :exists?, :exist? # LOL Ruby

  def single?
    raw_elements.length == 1
  end

  def_delegators :raw_elements, :each,
                                :length,
                                :size,
                                :[],
                                :first,
                                :last,
                                :empty?

  # Set union, used for joining complex finders (specifically for Watir1)
  def +(other)
    self.class.new(parent, raw_elements + other.raw_elements)
  end

  # Proxy for find_elements_by_id, find_elements_by_tag etc.
  OperaWatir::Selector::BASIC_TYPES.each do |type|
    define_method("find_elements_by_#{type}") do |value|
      _elms.inject([]) do |result, element|
        result | element.send("find_elements_by_#{type}", value.to_s)
      end
    end
  end

  def find_elements_by_attribute(attributes)
    _elms.select do |elm|
      attributes.all? {|attribute, value|
        elm.send(attribute).send((value.is_a?(Regexp) ? :match : :==), value)
      }
    end
  end

  def find_elements_by_index(n)
    (n >= 0 && n < _elms.length) ? [_elms[n]] : []
  end

  # No call to super. Collections are completely opaque proxies.
  # First we pass down to the elements
  #   If a method is found and it's all booleans, we .all? it
  #   otherwise we return an array of the results
  # If no method on the elements is found then we pass it to find_by_tag
  # NOTE this may cause some problems if people mis-spell things, as you can
  # call any method on a collection and it will always succeed
  def method_missing(method, *args, &blk)
    begin
      result = map_or_return {|elm| elm.send(method, *args, &blk) }
      if result.is_a?(Array) and result.all? { |e| !!e == e }
        result.all?
      else
        # Non-array or array of non-booleans
        result
      end
    rescue
      # Make sure this is a valid tag name
      # TODO consider XML and all the valid chars there
      if method.to_s.match(/^[a-z]+$/i)
        find_by_tag(method)
      else
        raise
      end
    end
  end

  def id
    map_or_return {|elm| elm.id}
  end

  # Public interface to elms, used in Selector
  def raw_elements
    _elms.tap do |e|
      raise(OperaWatir::Exceptions::UnknownObjectException) if e.empty?
    end
  end

  [:id, :tag, :css, :xpath].each do |type|
    define_method("find_by_#{type}") do |name|
      OperaWatir::Collection.new(self).tap do |c|
        c.selector.send(type, name.to_s)
      end
    end
  end

  # #class is reserved, so send to #class_name
  def find_by_class(name)
    OperaWatir::Collection.new(self).tap do |c|
      c.selector.class_name name.to_s
    end
  end

private

  def _elms
    @_elms ||= selector.eval
  end

  attr_writer :_elms

  def map_or_return(&blk)
    single? ? blk.call(raw_elements.first) : map(&blk)
  end

end
