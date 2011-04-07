require File.expand_path('../../watirspec_desktophelper', __FILE__)
require File.expand_path('../shared/shared', __FILE__)

describe 'QuickTreeView' do
  
	before(:all) do
		browser.open_dialog_with_action("New Preferences Dialog", "Show preferences", 4).should > 0
	end
  
	after(:all) do
		browser.close_all_dialogs
	end
 
	let(:widget) { browser.quick_treeview(:name, "Advanced_treeview") }
	subject { widget }
    
	it_behaves_like 'a widget'
  
	its(:type) { should == :treeview }

    
    describe '#num_treeitems' do
		it "returns numbers of treeitems in the treeview" do
			browser.quick_treeview(:name, "Advanced_treeview").num_treeitems.should > 0
		end

    end
    

end
