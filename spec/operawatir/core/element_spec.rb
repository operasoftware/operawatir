require File.expand_path('../../watirspec_helper', __FILE__)
require 'tmpdir'

describe 'Element' do

  describe '#triple_click' do
    it 'clicks three times' do
      browser.url = fixture('onclick.html')
      window.find_by_tag('button').triple_click
      window.find_by_id('clicks').text.should == '3'
    end
  end

  describe '#quadruple_click' do
    it 'clicks four times' do
      browser.url = fixture('onclick.html')
      window.find_by_tag('button').quadruple_click
      window.find_by_id('clicks').text.should == '4'
    end
  end

  # This method is deprecated, but needs to be tested anyway.
  describe '#compare_hash' do

    before :each do
      browser.url = fixture('boxes.html')
      @one   = window.find_by_id('one');
      @two   = window.find_by_id('two');
      @three = window.find_by_id('three');
    end

    it 'interprets two visually different elements as different' do
      @one.compare_hash(@two).should be_false
    end

    it 'interprets two visually identical elements as identical' do
      @one.compare_hash(@three).should be_true
    end
  end

  describe '#screenshot' do
    after (:each) do
      File.delete(Dir.tmpdir + '/screenshot.png')
    end

    it 'takes a screenshot of the specified element' do
      browser.url = fixture('boxes.html')
      window.find_by_id('one').screenshot(Dir.tmpdir + '/screenshot.png', 1000).should be_true
    end
  end

  describe '#visual_hash' do

    before :each do
      browser.url = fixture('boxes.html')
      @one   = window.find_by_id('one');
      @two   = window.find_by_id('two');
      @three = window.find_by_id('three');
      @four  = window.find_by_id('four');
    end

    it 'returns a hash' do
      @one.visual_hash.length.should == 34
    end

    it 'returns identical hashes for visually identical elements' do
      @one.visual_hash.should == @three.visual_hash
    end

    it 'returns different hashes for visually different elements' do
      @one.visual_hash.should_not == @two.visual_hash
    end

    it 'returns correct hashes when querying several elements in sequence' do
      @one.visual_hash.should     == @three.visual_hash
      @two.visual_hash.should     == @four.visual_hash
      @one.visual_hash.should_not == @two.visual_hash
      @two.visual_hash.should_not == @three.visual_hash
    end

  end

end
