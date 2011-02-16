require File.expand_path('../../watirspec_helper', __FILE__)

describe 'Spatnav' do

  before :each do
    browser.url = fixture('grid.html')
  end

  describe '#up' do
    it 'selects the correct links when navigating up' do
      browser.spatnav.up
      window.execute_script("document.activeElement.text;").to_s.should == 'C1'
      browser.spatnav.up
      window.execute_script("document.activeElement.text;").to_s.should == 'C2'
      browser.spatnav.up
      window.execute_script("document.activeElement.text;").to_s.should == 'C3'
    end
  end

  describe '#down' do
    it 'selects the correct links when navigating down' do
      browser.spatnav.down
      window.execute_script("document.activeElement.text;").to_s.should == 'C3'
      browser.spatnav.down
      window.execute_script("document.activeElement.text;").to_s.should == 'C2'
      browser.spatnav.down
      window.execute_script("document.activeElement.text;").to_s.should == 'C1'
    end
  end

  describe '#left' do
    it 'selects the correct links when navigating left' do
      browser.spatnav.left
      window.execute_script("document.activeElement.text;").to_s.should == 'C1'
      browser.spatnav.left
      window.execute_script("document.activeElement.text;").to_s.should == 'B1'
      browser.spatnav.left
      window.execute_script("document.activeElement.text;").to_s.should == 'A1'
    end
  end

  describe '#right' do
    it 'selects the correct links when navigating right' do
      browser.spatnav.right
      window.execute_script("document.activeElement.text;").to_s.should == 'A1'
      browser.spatnav.right
      window.execute_script("document.activeElement.text;").to_s.should == 'B1'
      browser.spatnav.right
      window.execute_script("document.activeElement.text;").to_s.should == 'C1'
    end
  end

  describe '#activate!' do
    it 'activates the focused link' do
      browser.spatnav.down
      browser.spatnav.activate
      window.url.should include 'C3'
    end
  end


end
