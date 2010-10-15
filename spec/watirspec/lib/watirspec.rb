# encoding: utf-8
module WatirSpec
  extend self

  attr_accessor :browser, :args, :guarded

  def fixture_path
    p File.expand_path('../../fixtures', __FILE__)
    File.expand_path('../../fixtures', __FILE__)
  end

  def fixture(*paths)
    p [host, *paths].join('/')
    [host, *paths].join('/')
  end
  
  def host
    "http://#{Server.bind}:#{Server.port}"
  end
  
  def guards
    @guards ||= []
  end

  def guarded?
    !!@guarded
  end

  def browser
    @browser ||= (
      b = WatirSpec::Browser.new
      yield b if block_given?
      b
    )
  end

end
