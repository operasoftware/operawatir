# encoding: utf-8
require 'spec_helper'
require 'guards'
require 'server'

require 'operawatir/helper'

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
      OperaWatir::Waiter.browser
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
