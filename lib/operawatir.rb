$LOAD_PATH.unshift File.expand_path('..', __FILE__)
require 'forwardable'
require 'deprecated'
require 'java'
include Java

%w(commons-jxpath-1.3.jar protobuf-java-2.3.0.jar selenium-common.jar
   webdriver-opera.jar commons-io-2.0.1.jar).each { |jar| require "operadriver/#{jar}" }

include_class org.openqa.selenium.WebDriver
include_class org.openqa.selenium.RenderedWebElement
include_class org.openqa.selenium.NoSuchElementException
include_class com.opera.core.systems.OperaDriver
include_class com.opera.core.systems.OperaWebElement
include_class com.opera.core.systems.settings.OperaDriverSettings

# Desktop stuff
include_class com.opera.core.systems.OperaDesktopDriver
include_class com.opera.core.systems.scope.protos.DesktopWmProtos
include_class com.opera.core.systems.scope.protos.SystemInputProtos
include_class com.opera.core.systems.QuickWidget

$KCODE = 'u'  # UTF-8 support

class Object
  def truthy?
    self && [true, 'true', 'yes', 'y', '1', 1].include?(self)
  end
end

# TODO This should be replaced when we decide upon a better way of
# enabling the Watir 3 API.
module OperaWatir
  @current_api = 2

  # Set the API version you wish to use.  Please note that setting
  # this after OperaWatir::Browser has been initialized will have no
  # affect.
  #
  # @param number [Integer] API version to use
  def self.api=(number)
    @current_api = number.to_i
  end

  # Queries which API to use.
  #
  # @return [Integer] Desired API version
  def self.api
    @current_api
  end
end

require 'operawatir/version'
require 'operawatir/platform'
require 'operawatir/keys'
require 'operawatir/screenshot'
require 'operawatir/preferences'
require 'operawatir/spatnav'

require 'operawatir/exceptions'
require 'operawatir/selector'
require 'operawatir/element'
require 'operawatir/collection'
require 'operawatir/window'
require 'operawatir/browser'

require 'operawatir/compat'

# Desktop stuff
require 'operawatir/desktop_enums'
require 'operawatir/desktop_common'
require 'operawatir/desktop_container'
require 'operawatir/desktop_browser'
require 'operawatir/quickwidgets'
require 'operawatir/desktop_exceptions'
