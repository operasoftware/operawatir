require File.expand_path('../../watirspec_helper', __FILE__)

describe OperaWatir::Spatnav do

  before :each do
    browser.url = fixture('grid.html')
    @spatnav = browser.spatnav
  end

  describe '#up' do
    it 'selects the correct links when navigating up' do
      @spatnav.up
      window.execute_script("document.activeElement.text;").to_s.should == 'C1'
      @spatnav.up
      window.execute_script("document.activeElement.text;").to_s.should == 'C2'
      @spatnav.up
      window.execute_script("document.activeElement.text;").to_s.should == 'C3'
    end
  end

  describe '#down' do
    it 'selects the correct links when navigating down' do
      @spatnav.down
      window.execute_script("document.activeElement.text;").to_s.should == 'C3'
      @spatnav.down
      window.execute_script("document.activeElement.text;").to_s.should == 'C2'
      @spatnav.down
      window.execute_script("document.activeElement.text;").to_s.should == 'C1'
    end
  end

  describe '#left' do
    it 'selects the correct links when navigating left' do
      @spatnav.left
      window.execute_script("document.activeElement.text;").to_s.should == 'C1'
      @spatnav.left
      window.execute_script("document.activeElement.text;").to_s.should == 'B1'
      @spatnav.left
      window.execute_script("document.activeElement.text;").to_s.should == 'A1'
    end
  end

  describe '#right' do
    it 'selects the correct links when navigating right' do
      @spatnav.right
      window.execute_script("document.activeElement.text;").to_s.should == 'A1'
      @spatnav.right
      window.execute_script("document.activeElement.text;").to_s.should == 'B1'
      @spatnav.right
      window.execute_script("document.activeElement.text;").to_s.should == 'C1'
    end
  end

  describe '#activate!' do
    it 'activates the focused link' do
      @spatnav.down
      @spatnav.activate
      window.url.should include 'C3'
    end
  end

end
