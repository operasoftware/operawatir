require File.expand_path('../../watirspec_desktophelper', __FILE__)
require File.expand_path('../shared/shared', __FILE__)

describe 'QuickRadiobox' do

  before(:all) do
    browser.open_dialog_with_action("New Preferences Dialog", "Show preferences", 4)
    browser.quick_treeview(:name, "Advanced_treeview").quick_treeitem(:string_id, "D_NEW_PREFS_COOKIES").activate_tab_with_click
  end
   
  after(:all) do
    browser.close_all_dialogs
  end
  
  let(:widget) {  browser.quick_radiobutton(:name, "Accept_cookies_radio") }
  subject { widget }
    
  it_behaves_like 'a widget'
  it_behaves_like 'a checkbox'
  
  its(:type) { should == :radiobutton }
    
  
end
