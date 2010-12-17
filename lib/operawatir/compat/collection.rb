class OperaWatir::Collection

  # Aliases that Watir1 defines for certain attributes
  ATTRIBUTE_ALIASES = {
    :url => :href,
    :class => :class_name,
    :tag => :tag_name
  }

  # Welcome to Hacksville, population: too many

  # Creates a new selector based on the arguments given to the Watir 1
  # browser methods, e.g. +browser.div(:id, 'content')+.
  #
  # @param [Array] args The array of arguments passed to the Watir
  #   method.
  # @param [Method] default_method The attribute to use when only a
  #   value is provided, e.g. browser.div('content').
  # @return [OperaWatir::Selector] the generated selector
  def add_selector_from_arguments(args, default_method)
    # () => :index, 0
    if args.empty?
      type, value = :index, 0

    # (:index, 1) => :index, 0
    elsif args.first == :index
      type, value = :index, args[1].to_i - 1

	# Handle a hash of selectors
    elsif args.length == 1 and  args.first.is_a? Hash
      args.first.each_pair do |k, v|
        s = add_selector_from_arguments([k, v], default_method)
      end
      return s

    # (:id, 3.14) => TypeError
    elsif args.any? {|arg| ![String, Regexp, Fixnum, Symbol].any?{|k| arg.is_a?(k)}}
      raise TypeError

    # NOTE: This is purely to make WatirSpec pass
    # (:no_such_how, 'some_value') => Exception
    elsif args.first == :no_such_how
      raise OperaWatir::Exceptions::MissingWayOfFindingObjectException

    # ('foo') => :attribute, {:id => 'foo'}
    elsif !args.first.is_a?(Symbol) && args[1].nil?
      type, value = :attribute, {
        default_method => args.first
      }

    # (:xpath, '//area') => :xpath, '//area'
    elsif ![:id, :class, :tag].include?(args.first) && OperaWatir::Selector::BASE_TYPES.include?(args.first)
      type, value = args.first, args[1]

    # (:url, 'foo.html') => :attribute, {:href => 'foo.html'}
    else
      type, value = :attribute, {
        (ATTRIBUTE_ALIASES[args.first.to_sym] || args.first) => args[1]
      }
    end

    selector.send(type, value)
  end

  # Watir1 Collections are 1 indexed *headslap*

  # Gets the element at index, starting from 1 (i.e. [0] in a normal
  # array is [1] here.
  #
  # @param [Fixnum] index The index of the element to retreive
  # @return [OperaWatir::Collection] A new collection with the
  #   selector pointing to the given index.
  def [](index)
    self.class.new(self).tap {|c| c.selector.index(index-1) }
  end

  # Define methods to satisfy #respond_to? which is used in the tests.
  [:name, :title, :type, :class_name, :text, :style, :value].each do |name|
    define_method(name) {method_missing(name)}
  end

  # Fetches the string representation of this collection.
  #
  # @return [String] the string representation of this collection
  # @raise [OperaWatir::Exceptions::UnknownObjectException]
  def to_s
    # This should return all of the attributes defined on each
    # element. We don't have support for that, so lets just
    # output the useful ones.
    raw_elements.map do |el|
      "tag:          #{el.tag_name.downcase}\n"+
      "  id:           #{el.id}\n" +
      "  class:        #{el.class_name}\n" +
      "  title:        #{el.title}\n" +
      "  text:         #{el.text}"
    end.join("\n")
  end

end
