require File.expand_path('../../spec_helper', __FILE__)

require 'operawatir/window'
require 'operawatir/collection'
require 'operawatir/selector'

describe OperaWatir::Selector do
  
  before do
    @browser = mock!
    @window = OperaWatir::Window.new(@browser)
  end
  
  ## Primitaves
  
  # window.id('foo')
  #   => document.getElementsById('bar')
  
  # window.classname('foo')
  #   => document.getElementsByClass('foo')
  
  # window.css('div#foo')
  #   => document.getElementsByCss('div#foo')
  
  # window.xpath('//foo')
  #   => document.getElementsByXpath('//foo')
  
  # window.div
  #   => document.getElementsByTagName('div')
  
  # window.divs
  #   => document.getElementsByTagName('div')
  
  # window.element
  #   => document.getElementsByTagName('*')
  
  # window.elements
  #   => document.getElementsByTagName('*')
  
  
  ## Fitlers
  
  # window.div(:id => 'foo') 
  #   => getElementsByTagName('div')
  #   => filter(:id => 'foo')
  
  # window.div(:class => 'foo')
  #   => getElementsByTagName('div')
  #   => filter(:class => 'bar')
  
  # window.div(:id => 'foo', :class => 'bar')
  #   => getElementsByTagName('div')
  #   => filter(:id => 'foo', :class => 'bar')
  
  # window.div(:id => 'foo', :class => 'bar', :baz => 'boop')
  #   => getElementsByTagName('div')
  #   => filter(:id => 'foo', :class => 'bar', :baz => 'boop')
  
  
  ## Sub-collections
  
  # window.header.h1
  #   => parent = getElementsByTagName('header')
  #   => parent.getElementsByTagName()
  
  
  # window.divs
  # divs
  
  # window.
  
  
  # div
  # window.div
  
  # div
  # window.divs
  
  
  
  
  it 'finds div' do
    # @browser.find_elements_by_tag(:div)
    @window.div
  end
  
  # it 'finds divs' do
  #   @browser.find_elements_by_tag(:div)
  #   @window.divs
  # end
  # 
  # it 'finds first element' do
  #   @browser.find_all_elements
  #   @window.element
  # end
  # 
  # it 'finds all elements' do
  #   @browser.find_all_elements
  #   @window.elements
  # end
  # 
  # it 'finds divs with id' do
  #   @browser.find_elements_by_tag(:div)
  #   # @window.
  # end
  
end
