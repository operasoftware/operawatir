module OperaWatir::Compat::Elements
  class FileField < TextField

    def set(path)
      clear unless value.empty?
      element,.click 1, 0
      element.sendKeys(path.split(//).to_java(:string))
    end

  end
end

