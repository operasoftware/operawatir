class OperaWatir::Element

  def attr(name)
    node.getAttribute(name.to_s) || ''
  end

  def attr?(name)
    !node.getAttribute(name.to_s).nil?
  end

  def method_missing(name, *args, &blk)
    attr(name)
  end
  
  def text
    node.getText.strip
  end
  
end
