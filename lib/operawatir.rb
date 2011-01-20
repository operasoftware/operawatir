module OperaWatir; end
require "operawatir/version"

require "java"
include Java

%w(commons-jxpath-1.3.jar protobuf-java-2.3.0.jar selenium-common.jar
   webdriver-opera.jar).each { |jar| require "operadriver/#{jar}" }

include_class org.openqa.selenium.WebDriver
include_class org.openqa.selenium.RenderedWebElement
include_class org.openqa.selenium.NoSuchElementException
include_class com.opera.core.systems.OperaDesktopDriver
include_class com.opera.core.systems.OperaDriver
include_class com.opera.core.systems.OperaWebElement
include_class com.opera.core.systems.scope.protos.DesktopWmProtos
include_class com.opera.core.systems.scope.protos.SystemInputProtos
include_class com.opera.core.systems.QuickWidget
include_class com.opera.core.systems.settings.OperaDriverSettings

require "operawatir/platform"
require "operawatir/exceptions"
require "operawatir/elements"
require "operawatir/collections"
require "operawatir/browser"

require "operawatir/desktop_enums"
require "operawatir/desktop_common"
require "operawatir/desktop_container"
require "operawatir/desktop_browser"
require "operawatir/quickwidgets"
require "operawatir/desktop_exceptions"
