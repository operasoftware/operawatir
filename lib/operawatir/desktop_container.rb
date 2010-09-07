module OperaWatir
  module DesktopContainer

    def quick_label(how,what)
      QuickLabel.new(self,how,what)
    end

    def quick_button(how, what)
      QuickButton.new(self, how, what)
    end

  end
end

