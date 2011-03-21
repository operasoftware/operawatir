require File.expand_path('../../watirspec_desktophelper', __FILE__)
require File.expand_path('../shared/shared', __FILE__)

describe 'QuickFind' do
  
   before(:all) do
     browser.open_dialog_with_action("New Preferences Dialog", "Show preferences", 4).should > 0
   end
   
   after(:all) do
     browser.close_all_dialogs
   end
  
   let(:widget) { browser.quick_find(:name, "Filetypes_quickfind") }
  
   subject { widget }
     
   it_behaves_like "a widget"
   
   describe "#quick_find" do
     it "constructs thumbnail by its name" do
      browser.quick_find(:name, "Filetypes_quickfind").should exist 
     end
   end
   
end