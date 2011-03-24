require File.expand_path('../../watirspec_desktophelper', __FILE__)
require File.expand_path('../shared/shared', __FILE__)

describe 'QuickDialogTab' do
	before(:all) do
		browser.open_dialog_with_action("New Preferences Dialog", "Show preferences").should > 0
	end
	
	after(:all) do
		browser.close_all_dialogs
	end
  
  let(:widget) { browser.quick_dialogtab(:name, "tab_prefs_advanced") }
  subject { widget }
    
  it_behaves_like 'a widget'
  
  its(:type) { should == :dialogtab }

  describe '#activate_tab_with_click' do
	 it 'activates a tab with click' do
	   browser.quick_dialogtab(:name, "tab_prefs_advanced").activate_tab_with_click
	   browser.quick_checkbox(:name, "Thumbnails_in_tab_cycle").should be_visible
	 end
  end
   
end



