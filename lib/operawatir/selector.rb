class OperaWatir::Selector
  BASIC_TYPES = [:id, :class, :tag, :css, :xpath]

  attr_accessor :type, :attribute, :value

  def initialize(collection, type, value)
    self.collection, self.type, self.value = collection, type, value || ''
  end

  def apply_to(elements)
    if basic?
      collection.parent.send(finder_method, value)
    else
      send(finder_method, elements || collection.parent.raw_elements)
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
    #obj.respond_to?(:match) ? :match : :==
    :==  # FIXME
  end

  def finder_method
    "find_elements_by_#{type}".to_sym
  end

  def find_elements_by_attribute(elements)
    elements.select do |element|
      value.all? do |key, val|
        element.send(key).send(self.class.operator(val), val)
      end
    end
  end

end
