class OperaWatir::Selector
  BASIC_TYPES = [:id, :class, :tag, :css, :xpath]
  
  attr_accessor :type, :attribute, :value
  
  def self.parse(collection, *args)
    case args.length
    when 0
      args
    when 1
      args.first.map {|type, value| new(collection, type, value)}
    else
      [new(
        collection,
        (args[0] == :index ? :index : :attribute),
        args[0],
        args[1]
      )]
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

  def operator
    value.respond_to?(:match) ? :match : :==
  end

  def finder_method
    "find_elements_by_#{type}".to_sym
  end

  def find_elements_by_index(elements)
    elements.select do |element|
      elements.index(element) == value
    end
  end
  
  def find_elements_by_attribute(elements)
    elements.select do |element|
      element.send(attribute).send(operator, value)
    end
  end
  
end
