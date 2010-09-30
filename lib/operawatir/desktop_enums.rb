module OperaWatir
  module DesktopEnums
    SOMETHING = 1
    KEYMODIFIER_ENUM_MAP = SystemInputProtos::ModifierPressed.constants.inject({}) do |acc, const|
      acc[const.to_s.downcase.to_sym] = SystemInputProtos::ModifierPressed.const_get(const)
      acc
    end
    
    MOUSEBUTTON_ENUM_MAP = SystemInputProtos::MouseInfo::MouseButton.constants.inject({}) do |acc, const|
      acc[const.to_s.downcase.to_sym] = SystemInputProtos::MouseInfo::MouseButton.const_get(const)
      acc
    end

    WIDGET_ENUM_MAP = DesktopWmProtos::QuickWidgetInfo::QuickWidgetType.constants.inject({}) do |acc, const|
      #puts const.inspect
      acc[const.to_s.downcase.to_sym] = DesktopWmProtos::QuickWidgetInfo::QuickWidgetType.const_get(const)
    acc
    end

  end
end
