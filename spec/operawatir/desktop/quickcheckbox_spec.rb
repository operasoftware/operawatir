require File.expand_path('../../watirspec_desktophelper', __FILE__)
require File.expand_path('../shared/shared', __FILE__)

describe 'QuickCheckbox' do

  before(:each) do
    browser.open_dialog_with_action("New Preferences Dialog", "Show preferences", 4)
    browser.quick_treeview(:name, "Advanced_treeview").quick_treeitem(:string_id, "D_NEW_PREFS_SECURITY").activate_tab_with_click
  end
   
  after(:each) do
     browser.close_all_dialogs
  end
  
  let(:widget) {  browser.quick_checkbox(:name, "Trust_info_checkbox") }
  subject { widget }
    
  it_behaves_like 'a checkbox'
    
  its(:type) { should == :checkbox }
    
  describe '#open_dialog_with_click' do
    it 'returns window id' do
      browser.quick_button(:name, "Set_password_button").open_dialog_with_click("Change Masterpassword Dialog").should > 0
      browser.quick_editfield(:name, "Password_edit").focus_with_click
      browser.quick_editfield(:name, "Password_edit").type_text("masterpass1").should == "masterpass1" 
      browser.quick_editfield(:name, "Confirm_password_edit").focus_with_click
      browser.quick_editfield(:name, "Confirm_password_edit").type_text("masterpass1").should == "masterpass1"
      browser.quick_button(:name, "button_OK").close_dialog_with_click("Change Masterpassword Dialog").should close_dialog
      browser.quick_checkbox(:name, "Master_password_checkbox").open_dialog_with_click("Security Password Dialog").should > 0
    end
  end
  
end


