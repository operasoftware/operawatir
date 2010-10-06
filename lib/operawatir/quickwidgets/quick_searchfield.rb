module OperaWatir
  class QuickSearchField < QuickEditField

    # @private
    # Checks the type of the widget is correct
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:search]
    end
    
  end
end