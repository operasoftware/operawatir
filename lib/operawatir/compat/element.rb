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

  def value
    if tag_name == 'INPUT'
      attr(:value)
    else
      text
    end
  end

  # In the compatibility layer as the preferred way of doing this is
  #   elm.text.should include('My string')
  def verify_contains(str)
    text.include?(str)
  end

  alias_method :verify_contains?, :verify_contains

  alias_method :caption, :text

  def click(x=0, y=0)
    assert_enabled!
    node.click(x.to_i, y.to_i)
  end

  def focus
    trigger! :focus
  end

  alias_method :fire_event, :trigger!

  def submit
    assert_exists
    node.submit
  end

  def clear
    assert_enabled!
    node.clear
  end

  # Set to text, but check on textboxes.
  def set(value=nil)
    if value
      self.text = value
    else
      check!
    end
  end

  def url
    attr(tag_name == 'A' ? :href : :url)
  end

  def selected_options
    options(:selected?, true)
  end

  def selected?(option=nil)
    if option.nil?
      selected_options.text.include?(option)
    else
      node.isSelected
    end
  end

  def type
    if tag_name == 'SELECT'
      attr(:multiple) == 'multiple' ? 'select-multiple' : 'select-one'
    else
      attr(:type)
    end
  end

  def colspan
    attr(:colspan).to_i
  end

private

  def assert_enabled!
    raise OperaWatir::Exceptions::ObjectDisabledException if disabled?
  end

end
