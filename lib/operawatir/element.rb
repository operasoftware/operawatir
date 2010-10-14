class OperaWatir::Element

  def initialize(node)
    self.node = node
  end
  
  # Attributes
  
  def [](attr)
    node.getAttribute(attr.to_s)
  end
  
  def method_missing(attr, *args, &blk)
    if self[attr] != nil
      self[attr]
    else
      super
    end
  end
  
  def id
    self['id']
  end
  
  # HACK Should be built into node
  def has_attribute?(attr)
    !self[attr].nil?
  end

  def enabled?
    node.isEnabled
  end
  
  def text
    node.getText
  end

  def html
    node.getHTML
  end

  def value
    node.getValue
  end

  def tag
    node.getElementName
  end
  
  def clear
    node.clear
  end
  
  
  # Events
  
  def click(x=0, y=0)
    node.click(x.to_i, y.to_i)
  end
  
  def click_async
    node.click 1
  end

  def double_click
    node.click 2
  end

  def triple_click
    node.click 3
  end

  def quadruple_click
    node.click 4
  end

  def right_click
    node.rightClick
  end
  
  def drag_and_drop_on(other)
    node.dragAndDropOn other.node
  end
  
  def submit
    node.submit
  end
  
  
  # UI
  
  def screenshot(file_name, time_out)
    node.saveScreenshot(file_name, time_out)
  end
  
  def visual_hash
    node.getImageHash
  end
  
  def location
    loc = node.getLocation
    {:x => loc.x.to_i, :y => loc.y.to_i}
  end
  
private

  attr_accessor :node

end
