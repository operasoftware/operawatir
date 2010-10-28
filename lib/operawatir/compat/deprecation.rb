module OperaWatir::Compat::Deprecation
  
  # def deprecate(name, alt)
  #   deprecated_name = "deprecated_#{name}".to_sym
  #   alias_method deprecated_name, name.to_sym
  #   define_method name.to_sym do |*args|
  #     warn 'Foo'
  #     
  #     
  #   end
  # end
  
  # deprecate :foo
  
  
end

class Object
  extend OperaWatir::Compat::Deprecation
end
