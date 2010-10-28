class Selector
  
  class << self
    attr_accessor :finders, :refinements
  end
  
  self.finders, self.refinements = {}, {}
  
  attr_accessor :type, :value
  attr_writer :operator
  
  def self.find_by(type, &blk)
    finders[type] = blk
  end
  
  def self.refine_by(type, &blk)
    refinements[type] = blk
  end
  
  def initialize(type, value, operator=nil)
    self.type, self.value, self.operator = type, value, operator
  end
  
  def operator
    @operator || (value.is_a?(Regexp) ? :=~ : :==)
  end
  
  def finder
    self.class.finders[type] || self.class.finders[:all]
  end
  
  def refinement
    self.class.refinements[type] || self.class.refinements[:attribute]
  end
  
  def find(obj)
    result = (obj.is_a?(OperaWatir::Window) ? finder : refinement).
              call(obj, self)
    raise OperaWatir::Exceptions::UnknownObjectException if result.empty?
    result
  end
  
end

# TODO Instance eval block so the selector doesn't need to be passed in.
#      The first time it is spelled out for clarity.
Selector.find_by :tag do |window, selector|
  window.find_elements_by_tag_name(selector.value)
end

Selector.find_by :xpath do |window, s|
  window.find_elements_by_xpath(s.value)
end

Selector.find_by :all do |window, s|
  window.find_all_elements
end

Selector.refine_by :index do |collection, s|
  [collection[s.value] || raise(OperaWatir::Exceptions::UnknownObjectException)]
end

Selector.refine_by :attribute do |collection, s|
  collection.select do |element|
    element.has_attribute?(s.type) && element[s.type].send(s.operator, s.value)
  end
end
