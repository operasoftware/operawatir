class OperaWatir::Selector
  
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
    result = instance_exec(obj, &(obj.is_a?(OperaWatir::Window) ? finder : refinement))
    raise OperaWatir::Exceptions::UnknownObjectException if result.empty?
    result
  end
  
  # Selectors
  
  find_by :tag do |window|
    window.find_elements_by_tag_name(value)
  end

  find_by :xpath do |window|
    window.find_elements_by_xpath(value)
  end

  find_by :all do |window|
    window.find_all_elements
  end

  refine_by :index do |collection|
    [collection[value] || raise(OperaWatir::Exceptions::UnknownObjectException)]
  end

  refine_by :attribute do |collection|
    collection.select do |element|
      element.has_attribute?(type) && element[type].send(operator, value)
    end
  end
  
end
