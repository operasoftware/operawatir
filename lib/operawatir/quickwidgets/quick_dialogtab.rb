module OperaWatir
  class QuickDialogTab < QuickWidget

    # @private
    # Checks the type of the widget is correct
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:dialogtab]
    end

    ######################################################################
    # Switches to the dialog tab by clicking on it
    #
    # @raise [DesktopExceptions::WidgetNotVisibleException] if the dialogtab
    #            is not visible
    #
    def activate_tab_with_click
      click

      # No event yet so just cheat and sleep
      sleep(0.1);
    end
  end
end
