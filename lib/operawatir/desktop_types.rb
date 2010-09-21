module OperaWatir
  class Enumeration
    def Enumeration.add_item(key,value)
      @hash ||= {}
      @hash[key]=value
    end
  
    def Enumeration.const_missing(key)
      @hash[key]
    end   
  
    def Enumeration.each
      @hash.each {|key,value| yield(key,value)}
    end
  
    def Enumeration.values
      @hash.values || []
    end
  
    def Enumeration.keys
      @hash.keys || []
    end
  
    def Enumeration.[](key)
      @hash[key]
    end
  end
  
  class MouseButton < Enumeration
    self.add_item(:LEFT, 0)
    self.add_item(:RIGHT, 1)
    self.add_item(:MIDDLE, 2)
  end

  class Modifier < Enumeration
    self.add_item(:NONE, 0)
    self.add_item(:CTRL, 1)
    self.add_item(:SHIFT, 2)
    self.add_item(:ALT, 4)
    self.add_item(:META, 8)
    self.add_item(:SUPER, 16)
  end
end

