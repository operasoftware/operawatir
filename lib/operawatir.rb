require "java"
include Java

module OperaWatir
  VERSION = File.read(File.join(File.dirname(__FILE__), "..", "VERSION")).strip

  def self.version
    VERSION
  end

  module Exceptions

    class OperaWatirException < StandardError; end

    class UnknownObjectException < OperaWatirException; end
    class MissingWayOfFindingObjectException < OperaWatirException; end
    class UnknownFrameException < OperaWatirException; end
    class NotImplementedException < OperaWatirException; end
  end
end

%w(commons-jxpath-1.3.jar protobuf-java-2.3.0.jar webdriver-common.jar
   winp-1.14.jar webdriver-opera.jar).
   each { |jar| require "operadriver/#{jar}" }

include_class org.openqa.selenium.WebDriver
include_class org.openqa.selenium.RenderedWebElement
include_class org.openqa.selenium.NoSuchElementException
include_class com.opera.core.systems.OperaDesktopDriver
include_class com.opera.core.systems.OperaDriver
include_class com.opera.core.systems.OperaWebElement
include_class com.opera.core.systems.scope.protos.DesktopWmProtos
include_class com.opera.core.systems.scope.protos.SystemInputProtos
include_class com.opera.core.systems.QuickWidget
include_class com.opera.core.systems.QuickWindow

require "operawatir/elements"
require "operawatir/collections"
require "operawatir/browser"
require "operawatir/desktop_enums"
require "operawatir/desktop_common"
require "operawatir/desktop_container"
require "operawatir/desktop_browser"
require "operawatir/quickwidgets"
require 'operawatir/quick_window'
