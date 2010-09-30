module OperaWatir
  class QuickButton < QuickWidget
 
    # Is the specified button the default one. Returns true if is default,
    # otherwise, returns false. 
    #
    # Raises:
    # NoSuchElementException::   if the element is not found.
    def default?
      element.isDefault
    end
    
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:button];
    end

    #
    # Raises:
    # NoSuchElementException::  if element is is not found.
    def open_window_with_click(win_name)
      wait_start
      click()
      wait_for_window_shown(win_name)
    end
    
    alias_method :open_dialog_with_click, :open_window_with_click
    
    #
    # Raises:
    # NoSuchElementException::  if element is is not found.
    def close_window_with_click(win_name)
      wait_start
      click()
      wait_for_window_close(win_name)
    end

    alias_method :close_dialog_with_click, :close_window_with_click
    
  end
end
