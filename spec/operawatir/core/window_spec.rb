require File.expand_path('../../watirspec_helper', __FILE__)
require 'tmpdir'

describe OperaWatir::Window do

  describe '#visual_hash' do
    before :each do
      browser.url = fixture('boxes.html')
      @reference = window.visual_hash
    end

     it 'returns a hash' do
      @reference.should match /^(0x)[a-f0-9]{32}$/
    end

    it 'returns identical hashes for visually identical pages' do
      browser.url = fixture('boxes.html')
      window.visual_hash.should == @reference
    end

    it 'returns different hashes for visually different pages' do
      browser.url = fixture('grid.html')
      window.visual_hash.should_not == @reference
    end

    it 'returns a hash of an SVG document' do
      browser.url = fixture('browsers.svg')
      browser.visual_hash.should match /^(0x)[a-f0-9]{32}$/
    end
  end


  #
  # This method is deprecated, but must be tested anyway.
  #

  describe '#eval_js' do
    it 'works the same way as execute_script' do
      window.eval_js('1+1').should == window.execute_script('1+1');
    end
  end

  #
  # The frames implementation is a relic from the old OperaWatir.  We
  # need to replace this with a better frames implementation in the
  # future.
  #

  describe '#frame' do
    before :all do
      require 'operawatir/compat/window'
      OperaWatir::Window.send :include, OperaWatir::Compat::Window
      browser.url = fixture('frames.html')
    end

    it 'will switch to the specified frame' do
      window.frame(:name, 'test')
      window.text.should include 'Lorem ipsum'
      window.text.should_not include 'foobar'
    end
  end

  describe '#switch_to_default' do
    before :all do 
      browser.url = fixture('frames.html')
      window.frame(:name, 'test')
    end

    it 'will switch back to the default top frame' do
      window.switch_to_default
      window.text.should include 'foobar'
      window.text.should_not include 'Lorem ipsum'
    end
  end

end
