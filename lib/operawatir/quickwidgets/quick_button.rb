module OperaWatir
  class QuickButton < QuickWidget
    
    def default?
      element.isDefault
    end
    
  end
end
