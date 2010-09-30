require "java"
include Java

module OperaWatir
  # @private
  VERSION = File.read(File.join(File.dirname(__FILE__), "..", "VERSION")).strip

  # @return [String] current version of OperaWatir
  def self.version
    VERSION
  end
  
  module Exceptions
    # Superclass for all OperaWatir exceptions
    # @example
    #   begin
    #     ...
    #   rescue OperaWatirException
    #   end
    class OperaWatirException < RuntimeError; end
    
    # Raised when a method is called on an object which doesn't have a corresponding
    # element.
    class UnknownObjectException < OperaWatirException; end

    # Raised when specifying an unknown way of finding an element.
    # @example
    #   browser.divs(:weird_method, 10)
    class MissingWayOfFindingObjectException < OperaWatirException; end
    
    # Raised when trying to switch to an unknown frame
    class UnknownFrameException < OperaWatirException; end

    # @todo Document this
    class NoValueFoundException < OperaWatirException; end

    # Raised when trying to perform an action on an element which is disabled
    class ObjectDisabledException < OperaWatirException; end
    
    # Raised when trying to access a table cell that doesn't exist.
    class UnknownCellException < OperaWatirException; end
  end
end

%w(commons-jxpath-1.3.jar protobuf-java-2.3.0.jar webdriver-common.jar
   winp-1.14.jar webdriver-opera.jar).
   each { |jar| require "operadriver/#{jar}" }

include_class org.openqa.selenium.WebDriver
include_class org.openqa.selenium.RenderedWebElement
include_class org.openqa.selenium.NoSuchElementException
include_class com.opera.core.systems.OperaDriver
include_class com.opera.core.systems.OperaWebElement

require 'operawatir/collections'
require 'operawatir/elements'
require 'operawatir/browser'
