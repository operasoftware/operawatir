module OperaWatir::Compat::Selector
  
  def self.included(klass)
    klass.class_eval do
      
      # We don't implement selecting a tag then refining it with an XPath. To
      # do that would require a custom XPath parser/compiler.
      refine_by :xpath do |collection|
        deprecation! 'Refining collection by xpath', 'Fix by using browser.element(:xpath => ...)'
      end
      
      # Watir1 breaks all computer science idioms and is 1 indexed.
      refine_by :index do |collection|
        [collection[value-1] || raise(OperaWatir::Exceptions::UnknownObjectException)]
      end
      
      refine_by :url do |collection|
        collection.select do |element|
          element.has_attribute?(:href) && element[:href].send(operator, value)
        end
      end
      
      refine_by :attribute do |collection|
        raise TypeError if value.is_a?(Float)
        
        raise OperaWatir::Exceptions::MissingWayOfFindingObjectException unless [:id, :name, :title, :url, :href, :xpath, :index].include?(type)
        
        collection.select do |element|
          element.has_attribute?(type) && element[type].send(operator, value)
        end
      end
      
    end
  end
  
end
