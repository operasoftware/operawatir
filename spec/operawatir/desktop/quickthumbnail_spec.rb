require File.expand_path('../../watirspec_desktophelper', __FILE__)
require File.expand_path('../shared/shared', __FILE__)

describe 'QuickThumbnail' do
  
   let(:widget) { browser.quick_window(:name, "Browser Window").quick_toolbar(:name, "Pagebar").quick_tab(:name, "Tab 0") }
  
   subject { widget }
     
   it_behaves_like "a widget"
   it_behaves_like "a button"
   
  describe "#quick_thumbnail" do
     it "constructs thumbnail by its position"
     it "constructs thumbnail by its name"
     it "constructs thumbnail by its text"
   end
   
end