class OperaWatir::Selector
  BASE_TYPES       = [:id, :class_name, :tag_name, :css, :xpath]
  COLLECTION_TYPES = [:index, :attribute]
  META_TYPES       = [:join, :antijoin]
  
  TYPES = BASE_TYPES + COLLECTION_TYPES + META_TYPES
  
  attr_accessor :collection, :sexp

  def initialize(collection, sexp=nil)
    self.collection, self.sexp = collection, sexp
  end

  def eval(exp=sexp)
    exp.is_a?(Array) ? apply(*exp.map {|x| eval(x)}) : exp
  end

  def apply(fn, *args)
    elms = args.shift
    
    # Say hello to the the ol' send trick.
    # Private methods can be called when using send. This "bug" was briefly
    # disabled in 1.9 but people complained because it's very handy (but bad).
    if elms.nil?
      collection.parent.send("find_elements_by_#{fn}", *args)
    else
      collection.send(:_elms=, elms)
      if META_TYPES.include?(fn)
        send("apply_#{fn}", elms, args)
      else
        collection.send("find_elements_by_#{fn}", *args)
      end
    end
  end

  (BASE_TYPES + COLLECTION_TYPES).each do |name|
    define_method name do |val|
      self.sexp = [name, sexp, val]
      self
    end
  end

  META_TYPES.each do |name|
    define_method name do |&blk|
      list = BlockBuilder.new(self)
      blk.call(list)
      self.sexp = list.items.inject([name]) do |items, item|
        items << item.sexp
      end
      self
    end
  end
  
  # Handy shortcut
  
  alias_method :tag, :tag_name

private
  
  def apply_join(base, elms)
    elms.inject(base) do |col, elm|
      col | elm
    end
  end
  
  def apply_antijoin(base, elms)
    elms.inject(base) do |col, elm|
      col - elm
    end
  end
  
  def apply_antijoin(elms)
    elms.inject([]) do |result, elm|
      result - elm
    end
  end
  
  class BlockBuilder
    attr_accessor :selector, :items

    def initialize(selector)
      self.selector, self.items = selector, []
    end

    def method_missing(*args, &blk)
      OperaWatir::Selector.new(selector.collection, selector.sexp).send(*args, &blk).tap do |s|
        items << s
      end
    end
  end

end
