require File.expand_path('../../watirspec_desktophelper', __FILE__)

describe 'QuickLayout' do
  
   #let(:widget) { browser.quick_label(:name, "label_for_Name_edit") }
   #subject { widget }
   #it_behaves_like "a widget"
  #its(:type) { should == :gridlayout }
   
   describe ''#quick_gridlayout' do
     it 'constructs grid_layout by its name' do
      browser.quick_gridlayout(:name, "some_name") 
     end
   end
   
end