module OperaWatir
  class QuickButton < QuickWidget
    
    def default?
      @element.IsDefault
    end
    
  end
end
