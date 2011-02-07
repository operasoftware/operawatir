require 'colorize'

class OperaWatir::Exceptions::DeprecationException < OperaWatir::Exceptions::OperaWatirException
  
  def initialize(desc, fix, trace)
    @desc, @fix = desc, fix
    set_backtrace clean_backtrace(trace)
  end
  
  def message
    message = "DEPRECATION: #{@desc}".red
    message << "\n#{@fix.green}" unless @fix.empty?
    message
  end

private

  LIB_PATHS = [File.expand_path('../../../', __FILE__)] + Gem.all_load_paths

  def clean_backtrace(trace)
    trace.reject do |line|
      LIB_PATHS.any? do |lib_path|
        line.include?(lib_path)
      end || line.split(':').first == ''
    end
  end

end

module OperaWatir
  module Deprecation
      
    def deprecation(desc, fix='')
      warn OperaWatir::Exceptions::DeprecationException.new(desc, fix, caller).message
    end
  
    def deprecation!(desc, fix='')
      raise OperaWatir::Exceptions::DeprecationException.new(desc, fix, caller)
    end
      
  end
end

class Object
  include OperaWatir::Deprecation
end
