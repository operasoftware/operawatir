class OperaWatir::Selector
  BASIC_TYPES = [:id, :class, :tag, :css, :xpath]
  
  attr_accessor :type, :attribute, :value
  
  
  def self.parse_and_build(collection, *args)
    parse(args).map do |params|
      new(collection, *params)
    end
  end
  
  def self.parse(args)
    if args.empty?
      [[:index, 0]]
    else
      args.first.map {|name, value| [:attribute, name, value]}
    end
  end
  
  def initialize(collection, type, attribute, value=nil)
    self.collection, self.type = collection, type
    
    attribute, value = value, attribute if value.nil?    
    self.attribute, self.value = attribute, value
  end
  
  def apply_to(elements)
    if basic?
      collection.parent.send(finder_method, value)
    else
      send(finder_method, elements || collection.parent.elements)
    end.tap do |result|
      raise(OperaWatir::Exceptions::UnknownObjectException) if result.empty?
    end
  end
  
private

  attr_accessor :collection

  def basic?
    BASIC_TYPES.include?(type)
  end

  def self.operator(obj)
    obj.respond_to?(:match) ? :match : :==
  end

  def finder_method
    "find_elements_by_#{type}".to_sym
  end
  
  def find_elements_by_index(elements)
    # TODO Refactor
    if value < elements.length
      [elements[value]]
    else
      []
    end
  end
  
  def find_elements_by_attributes(elements)
    elements.select do |element|
      value.all? do |key, val|
        element.send(key).send(self.class.operator(val), val)
      end
    end
  end
  
end
