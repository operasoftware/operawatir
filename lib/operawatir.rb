module OperaWatir; end
require "operawatir/version"

require "java"
include Java

%w(commons-jxpath-1.3.jar protobuf-java-2.3.0.jar webdriver-common.jar
   winp-1.14.jar webdriver-opera.jar).
   each { |jar| require "operadriver/#{jar}" }

include_class org.openqa.selenium.WebDriver
include_class org.openqa.selenium.RenderedWebElement
include_class org.openqa.selenium.NoSuchElementException
include_class com.opera.core.systems.OperaDriver
include_class com.opera.core.systems.OperaWebElement

require "operawatir/exceptions"
require "operawatir/elements"
require "operawatir/collections"
require "operawatir/browser"
