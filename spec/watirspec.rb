# encoding: utf-8

module WatirSpec
  extend self

  attr_accessor :args, :guarded
  
  def host
    "http://#{Server.bind}:#{Server.port}"
  end

  def guards
    @guards ||= []
  end

  def guarded?
    !!@guarded
  end
  
  module Helpers
    def fixture(*paths)
      [WatirSpec.host, *paths].join('/')
    end
  end
  
end
