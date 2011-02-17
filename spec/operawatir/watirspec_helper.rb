# encoding: utf-8
$LOAD_PATH.unshift File.dirname(__FILE__)
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rspec'

require 'guards'
require 'server'

require 'operawatir/helper'

OperaWatir.api = 2

RSpec.configure do |config|
  config.mock_with :rr
end

module WatirSpec
  extend self

  attr_accessor :args, :guarded

  def host
    "http://#{Server.bind}:#{Server.port}"
  end
  alias_method :files, :host

  def guards
    @guards ||= []
  end

  def guarded?
    !!@guarded
  end

  module Helpers
    def browser
      OperaWatir::DesktopHelper.browser
    end

    def window
      browser.active_window
    end

    def fixture(*paths)
      [WatirSpec.host, *paths].join('/')
    end
  end

end

include OperaWatir::Exceptions

include WatirSpec::Guard::Helpers

RSpec.configure do |config|
  config.include WatirSpec::Helpers

  config.before(:suite) do
    Thread.new { WatirSpec::Server.run! }
  end
end

