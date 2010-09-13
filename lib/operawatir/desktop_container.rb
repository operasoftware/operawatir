module OperaWatir
  module DesktopContainer
    def quick_button(how, what)
      QuickButton.new(self, how, what)
    end

    def quick_checkbox(how, what)
      QuickCheckbox.new(self, how, what)
    end

    def quick_dialog_tab(how, what)
      QuickDialogTab.new(self, how, what)
    end

    def quick_dropdown(how, what)
      QuickDropdown.new(self, how, what)
    end

    def quick_editfield(how, what)
      QuickEditField.new(self, how, what)
    end

    def quick_label(how,what)
      QuickLabel.new(self,how,what)
    end

    def quick_radiobutton(how, what)
      QuickRadioButton.new(self, how, what)
    end
  end
end

