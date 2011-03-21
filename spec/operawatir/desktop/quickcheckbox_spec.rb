require File.expand_path('../../watirspec_desktophelper', __FILE__)
require File.expand_path('../shared/shared', __FILE__)

describe 'QuickCheckbox' do

	#describe '' do
		before(:all) do
			browser.open_dialog_with_action("Clear Private Data Dialog", "Delete private data").should > 0
			browser.quick_button(:name, "Destails_expand").toggle_with_click
		end
   
   		after(:all) do
			browser.close_all_dialogs
		end
  
		let(:widget) {  browser.quick_checkbox(:name, "Delete_all_cookies") }
		subject { widget }
    
		it_behaves_like 'a checkbox'
   # end
	
    describe '#correct_type?' do
    end

    describe '#checked?' do
    end
    
    describe '#toggle_with_click' do
    end

    
    describe '#open_dialog_with_click' do
    end

end