class OperaWatir::Selector
  ROOT_OPS = [:id, :class, :tag, :css, :xpath]

  attr_accessor :collection, :ops

  def initialize(collection)
    self.collection, self.ops = collection, []
  end

  ROOT_OPS.each do |op|
    define_method(op) do |value|
      self.ops << [op, value]
    end
  end
  
  def attrib(attribs={})
    self.ops << [:attrib, attribs]
  end
  
  def apply(parent)
    ops.inject(nil) do |elements, op|
      if ROOT_OPS.include?(op.first)
        elements = parent.send("find_by_#{op.first}", op.last)
      end
      
      if elements.nil?
        elements = parent.elements
      end
      
      if !ROOT_OPS.include?(op.first)
        elements = collection.class.refine_by_attributes(elements, op.last)
      end
      
      puts
      puts "ELEMENTS = #{elements.inspect}"
      puts
      
      elements
    end
    
  end
  
end
