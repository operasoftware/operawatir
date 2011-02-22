require File.expand_path('../../watirspec_helper', __FILE__)
require 'tmpdir'

describe 'Window' do

  describe '#screenshot' do
    after (:each) do
      File.delete(Dir.tmpdir + '/screenshot.png')
    end

    it 'takes a screenshot of the specified element' do
      browser.url = fixture('boxes.html')
      window.screenshot(Dir.tmpdir + '/screenshot.png').should be_true
    end
  end

  describe '#visual_hash' do
    before :each do
      browser.url = fixture('boxes.html')
      @reference = window.visual_hash
    end

     it 'returns a hash' do
      @reference.length.should == 34
    end

    it 'returns identical hashes for visually identical pages' do
      browser.url = fixture('boxes.html')
      window.visual_hash.should == @reference
    end

    it 'returns different hashes for visually different elements' do
      browser.url = fixture('grid.html')
      window.visual_hash.should_not == @reference
    end
  end

end
