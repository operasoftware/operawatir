require File.expand_path('../../watirspec_helper', __FILE__)

describe 'Element' do

  describe '#quadruple_click' do
    
    it 'clicks four times' do
      browser.url = fixture('onclick.html')
      window.find_by_tag('button').quadruple_click
      window.find_by_id('clicks').text.should == '4'
    end
    
    it 'selects a full paragraph' do
      browser.url = fixture('paragraphs.html')
      p = window.find_by_id('first')
      p.quadruple_click
      window.eval_js('var first = document.getElementById("first"); first.value.substr(first.selectionStart, first.selectionEnd - first.selectionStart)').to_s.should == p.text
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
