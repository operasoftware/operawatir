class OperaWatir::Element

  def attr(name)
    node.getAttribute(name.to_s) || ''
  end

  def attr?(name)
    !node.getAttribute(name.to_s).nil?
  end

  def method_missing(name, *args, &blk)
    if !block_given? && args.empty?
      attr(name)
    else
      super
    end
  end
  
  def text
    node.getText.strip
  end

  alias_method :value, :text
  
  # In the compatibility layer as the preferred way of doing this is
  #   elm.text.should include('My string')
  def verify_contains(str)
    text.include?(str)
  end

  alias_method :verify_contains?, :verify_contains

end
