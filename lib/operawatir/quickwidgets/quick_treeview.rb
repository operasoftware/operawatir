module OperaWatir
  class QuickTreeView < QuickWidget

    # @private
    # Checks the type of the widget is correct
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:treeview]
    end

    #Should rather use what's already in browser
    def treeitems
      treeitems = driver.getQuickWidgetList(driver.getQuickWindowName(window_id)).map do |java_widget|
        case java_widget.getType
          when QuickWidget::WIDGET_ENUM_MAP[:treeitem]
            QuickTreeItem.new(self,java_widget)
        end
      end.select { |item| item != nil }
      treeitems.select {|item| item.parent_name == name }
    end
    
    def num_treeitems
      treeitems.select { |item| item.position[1] == 0 }.length
    end
    
  end
end

