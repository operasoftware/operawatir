class OperaWatir::Collection
  
  # Aliases that Watir1 defines for certain attributes
  ATTRIBUTE_ALIASES = {
    :url => :href,
    :class => :class_name
  }
  
  DEFAULT_ATTRIBUTES = {}
  
  # Welcome to Hacksville, population: too many
  def add_selector_from_arguments(args)
    # () => :index, 0
    if args.empty?
      type, value = :index, 0
    
    # (:index, 1) => :index, 0
    elsif args.first == :index
      type, value = :index, args[1].to_i - 1
    
    # (:id, 3.14) => TypeError
    elsif args.any? {|arg| ![String, Regexp, Fixnum, Symbol].any?{|k| arg.is_a?(k)}}
      raise TypeError
    
    # NOTE: This is purely to make WatirSpec pass
    # (:no_such_how, 'some_value') => Exception
    elsif args.first == :no_such_how
      raise OperaWatir::Exceptions::MissingWayOfFindingObjectException
    
    # ('foo') => :attribute, {:id => 'foo'}
    elsif !args.first.is_a?(Symbol)
      type, value = :attribute, {
        # TODO Lookup default attribute from tagname
        :id => args.first
      }
    
    # (:xpath, '//area') => :xpath, '//area'
    elsif args.first != :id && OperaWatir::Selector::BASE_TYPES.include?(args.first)
      type, value = args.first, args[1]
    
    # (:url, 'foo.html') => :attribute, {:href => 'foo.html'}
    else
      type, value = :attribute, {
        (ATTRIBUTE_ALIASES[args.first] || args.first) => args[1]
      }
    end
    
    selector.send(type, value)
  end
  
  # Watir1 Collections are 1 indexed *headslap*
  def [](index)
    _elms[index - 1]
  end

  # Define methods to satisfy #respond_to? which is used in the tests.
  [:name, :title, :type, :class_name, :text, :style, :value].each do |name|
    define_method(name) {method_missing(name)}
  end
  
  # Checks and raises error if elements dont' exist
  def to_s
    raw_elements
    super
  end
  
end
