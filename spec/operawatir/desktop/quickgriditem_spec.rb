require File.expand_path('../../watirspec_desktophelper', __FILE__)

describe 'QuickItem' do
  
   #let(:widget) { browser.quick_label(:name, "label_for_Name_edit") }
   #subject { widget }
   #it_behaves_like "a widget"
   
   describe "#quick_griditem" do
     it "constructs grid_item by its name" do
      browser.quick_griditem(:name, "some_name") 
     end
   end
   
end