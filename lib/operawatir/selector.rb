class Selector
  
  class << self
    attr_accessor :finders, :refinements
  end
  
  self.finders, self.refinements = {}, {}
  
  attr_accessor :type, :operator, :value
  
  def self.find_by(type, &blk)
    finders[type] = blk
  end
  
  def self.refine_by(type, &blk)
    refinements[type] = blk
  end
  
  def initialize(type, operator, value)
    self.type, self.operator, self.value = type, operator, value
  end
  
  def finder
    self.class.finders[type]
  end
  
  def find(window)
    finder.call(window, self)
  end
  
  def refinement
    self.class.refinements[self.class.refinements.has_key?(type) ? type : :attribute]
  end
  
  def refine(collection)
    refinement.call(collection, self)
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

Selector.refine_by :index do |collection, s|
  [collection[s.value]]
end

Selector.refine_by :attribute do |collection, s|
  collection.select do |element|
    element.has_attribute?(s.type) && element[s.type].send(s.operator, s.value)
  end
end
