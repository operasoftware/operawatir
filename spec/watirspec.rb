# encoding: utf-8

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
