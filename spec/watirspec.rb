# encoding: utf-8

module WatirSpec
  extend self

  attr_accessor :args, :guarded
  
  def host
    "http://#{Server.bind}:#{Server.port}"
  end
  
  def fixture_path
    './fixtures'
  end

  def fixture(*paths)
    [host, *paths].join('/')
  end
  
  def guards
    @guards ||= []
  end

  def guarded?
    !!@guarded
  end
end
