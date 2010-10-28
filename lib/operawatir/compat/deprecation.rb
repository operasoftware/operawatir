module OperaWatir::Compat::Deprecation
  
  def self.included(klass)
    klass.extend ClassMethods
  end
  
  module ClassMethods
  end
  
  def deprecation(desc, fix)
    warn OperaWatir::Exceptions::DeprecationException.new(desc, fix, caller).message
  end
  
  def deprecation!(desc, fix)
    raise OperaWatir::Exceptions::DeprecationException.new(desc, fix, caller)
  end
  
end

class OperaWatir::Exceptions::DeprecationException < OperaWatir::Exceptions::OperaWatirException
  
  LIB_PATHS = [File.expand_path('../../../', __FILE__)] + Gem.all_load_paths
  
  def initialize(desc, fix, trace)
    @desc, @fix = desc, fix
    set_backtrace clean_backtrace(trace)
  end
  
  def message
    "DEPRECATION: #{@desc}\n  #{@fix}"
  end

private

  def clean_backtrace(trace)
    trace.reject do |line|
      LIB_PATHS.any? do |lib_path|
        line.include?(lib_path)
      end || line.split(':').first == ''
    end
  end
  
end


class Object
  include OperaWatir::Compat::Deprecation
end


