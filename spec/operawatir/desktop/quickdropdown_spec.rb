require File.expand_path('../../watirspec_desktophelper', __FILE__)
require File.expand_path('../shared/shared', __FILE__)

describe 'QuickDropdown' do

	before(:all) do
		browser.open_dialog_with_action("New Preferences Dialog", "Show preferences", 0).should > 0
	end
  
	after(:all) do
		browser.close_all_tabs
		browser.close_all_dialogs
	end
  
	let(:widget) { browser.quick_dropdown(:name, "Startup_mode_dropdown") }
	subject { widget }
    
	it_behaves_like 'a widget'

	
	describe '#selected?'do
		it 'returns true for selected item' do
			browser.quick_dropdown(:name, "Startup_mode_dropdown").selected?("D_STARTUP_LAST_TIME").should be_true
		end
		
		it 'returns false for not selected item' do
			browser.quick_dropdown(:name, "Startup_mode_dropdown").selected?("D_STARTUP_SAVED_SESSIONS").should be_false
		end
		
		it 'raises an exception' do
			browser.close_all_dialogs
			lambda { browser.quick_dropdown(:name, "Startup_mode_dropdown").selected?("D_STARTUP_SAVED_SESSIONS") }.should raise_error OperaWatir::DesktopExceptions::UnknownObjectException
		end
		
    end
    

end 

