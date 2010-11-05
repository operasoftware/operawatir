class OperaWatir::Selector
  TYPES = [:id, :class, :tag, :css, :xpath, :attribs]

  attr_accessor :collection, :ops

  def initialize(collection)
    self.collection, self.ops = collection, []
  end

  TYPES.each do |type|
    op = "find_by_#{type}".to_sym
    define_method op do |value|
      self.ops << [op, value]
    end
  end
  
  def find_by_attribs(method, value)
    self.ops << [:find_by_attribs, {method => value}]
  end

  def apply(parent)
    ops.inject(nil) do |elements, op|
      
      if parent.is_a?(Window) and elements.nil?
        parent.send(op.first, op.last)
      else
        send(op.first)
      end
      puts
      puts "elements: #{elements}, op: #{op.first}(#{op.last.inspect})"
      puts
      a  = elements.send(op.first, op.last)
      puts a
      a
      
    end
  end
end
