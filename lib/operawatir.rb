require 'java'
include Java

module OperaWatir
  VERSION = File.read(File.join(File.dirname(__FILE__), '..', 'VERSION')).strip

  def self.version
    VERSION
  end
end

%w(commons-jxpath-1.3.jar protobuf-java-2.3.0.jar webdriver-common.jar
   winp-1.14.jar webdriver-opera.jar).
   each {|jar| require "operadriver/#{jar}"}

include_class org.openqa.selenium.WebDriver
include_class org.openqa.selenium.RenderedWebElement
include_class org.openqa.selenium.NoSuchElementException
include_class com.opera.core.systems.OperaDriver
include_class com.opera.core.systems.OperaWebElement

require 'operawatir/container'
require 'operawatir/browser'
require 'operawatir/elements'
