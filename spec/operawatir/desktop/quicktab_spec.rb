require File.expand_path('../../watirspec_desktophelper', __FILE__)
require File.expand_path('../shared/shared', __FILE__)

describe 'QuickTab' do
  
   let(:widget) { browser.quick_window(:name, "Browser Window").quick_toolbar(:name, "Pagebar").quick_tab(:name, "Tab 0") }
  
   subject { widget }
     
   it_behaves_like "a widget"
   it_behaves_like "a button"
   
  describe "#quick_tab" do
    it "constructs tabbutton by its position"
    it "constructs tabbutton by its name"
    it "constructs tabbutton by its text"
  end

end