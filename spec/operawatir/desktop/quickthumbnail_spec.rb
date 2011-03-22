require File.expand_path('../../watirspec_desktophelper', __FILE__)
require File.expand_path('../shared/shared', __FILE__)

describe 'QuickThumbnail' do
  
  before(:all) do
    browser.open_window_with_key_press("Document Window", "t", :ctrl)
  end
  
  let(:widget) { browser.quick_thumbnail(:name, "Speed Dial 1") }
  
  subject { widget }
     
  it_behaves_like "a widget"
  it_behaves_like "a button"
   
  #This is really on browser, widgets, and window
  describe "#quick_thumbnail" do
    it "constructs thumbnail by its position"
    it "constructs thumbnail by its name"
    it "constructs thumbnail by its text"
  end
   
end