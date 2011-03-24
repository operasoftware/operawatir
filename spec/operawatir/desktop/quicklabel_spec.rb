require File.expand_path('../../watirspec_desktophelper', __FILE__)
require File.expand_path('../shared/shared', __FILE__)

describe 'QuickLabel' do
  
   before(:all) do
     browser.open_dialog_with_key_press("Add Bookmark Dialog", 'd', :ctrl)
   end
   
   after(:all) do
     browser.close_all_dialogs
   end
  
   let(:widget) { browser.quick_label(:name, "label_for_Name_edit") }
  
   subject { widget }
     
   it_behaves_like "a widget"
   
   its(:type) { should == :label }
   
   describe "#quick_label" do
     it "constructs label by its name" do
      browser.quick_label(:name, "label_for_Name_edit").should exist 
     end
   end
   
end