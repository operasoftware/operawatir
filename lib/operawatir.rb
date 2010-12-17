$LOAD_PATH.unshift File.expand_path('..', __FILE__)
require 'forwardable'
require 'java'
include Java

%w(commons-jxpath-1.3.jar protobuf-java-2.3.0.jar selenium-common.jar
   winp-1.14.jar webdriver-opera.jar).
   each { |jar| require "operadriver/#{jar}" }

include_class org.openqa.selenium.WebDriver
include_class org.openqa.selenium.RenderedWebElement
include_class org.openqa.selenium.NoSuchElementException
include_class com.opera.core.systems.OperaDesktopDriver
include_class com.opera.core.systems.OperaDriver
include_class com.opera.core.systems.OperaWebElement
include_class com.opera.core.systems.settings.OperaDriverSettings

$KCODE = 'u'  # UTF-8 support

# TODO This should be replaced when we decide upon a better way of
# enabling the Watir 2 API.
module OperaWatir
  @shiny = false

  # Activates the Watir 2 API.
  def self.newandshinyplease!
    @shiny = true
  end

  # Queries whether the Watir 2 API is enabled.
  #
  # @return [Boolean] whether or not Watir 2 API is enabled.
  def self.newandshinyplease?
    @shiny
  end
end

require 'operawatir/version'

require 'operawatir/exceptions'
require 'operawatir/selector'
require 'operawatir/element'
require 'operawatir/collection'
require 'operawatir/window'
require 'operawatir/browser'

require 'operawatir/compat'
