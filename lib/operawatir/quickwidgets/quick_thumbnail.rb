module OperaWatir
  class QuickThumbnail < QuickWidget
 
    # @private
    # Checks the type of the widget is correct
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:thumbnail]
    end
    
    ######################################################################
    # Drag and drop this speeddial
    #
    # @param [QuickThumbnail] Thumbnail to drop this thumbnail on
    #
    # @raise [DesktopExceptions::UnknownObjectException] if the target is not a thumbnail
    #
    def move_with_drag(tab_target)
      raise(Exceptions::UnknownObjectException) unless tab_target.type == :thumbnail
      drag_and_drop_on(tab_target, :center)
      
      sleep(0.1)
    end
    
  end
end