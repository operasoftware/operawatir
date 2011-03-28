require File.expand_path('../../watirspec_desktophelper', __FILE__)
require File.expand_path('../shared/shared', __FILE__)

describe 'QuickTreeItem' do
  
  describe 'a widget' do
	before(:all) do
		browser.open_window_with_key_press("Bookmarks Panel Window", "b", :ctrl, :shift) 
	end
  
	after(:all) do
		browser.close_all_tabs
	end
  
	let(:widget) { browser.quick_window(:name, "Bookmarks Panel Window").quick_treeview(:name, "Bookmarks View").quick_treeitem(:pos, [0, 0]) }
	subject { widget }
    
  it_behaves_like 'a widget'
  
  its(:type) { should == :treeitem }

  #describe '#correct_type?' do
  #end

  describe '#focus_with_click' do
  
		before(:all) do
			browser.open_dialog_with_action("New Preferences Dialog", "Show preferences").should > 0
			browser.quick_dialogtab(:name, "tab_prefs_advanced").activate_tab_with_click
		end
		
		it 'focus a treeitem' do
			 browser.quick_treeview(:name, "Advanced_treeview").quick_treeitem(:string_id, "D_NEW_PREFS_SHORTCUTS").focus_with_click
			 browser.quick_checkbox(:name, "Mouse_gestures_checkbox").should be_visible
		end
	
		
		after(:all) do
			browser.close_all_dialogs
		end
  end
        
  describe '#expand_with_click' do
		before(:all) do
			browser.open_dialog_with_action("New Preferences Dialog", "Show preferences").should > 0
			browser.quick_dialogtab(:name, "tab_prefs_advanced").activate_tab_with_click
			browser.quick_treeview(:name, "Advanced_treeview").quick_treeitem(:string_id, "D_NEW_PREFS_SHORTCUTS").activate_tab_with_click
			browser.quick_button(:name, "button_keyboard_Edit").open_dialog_with_click("Input Manager Dialog").should > 0
		end
	
		it 'expand with click' do
			browser.quick_treeview(:name, "Input_treeview").quick_treeitem(:text, "Application    (defaults)").expand_with_click
			browser.quick_treeview(:name, "Input_treeview").quick_treeitem(:text, "Copy").should be_visible
		end

		it 'collapse with click ' do
			browser.quick_treeview(:name, "Input_treeview").quick_treeitem(:text, "Application    (defaults)").collapse_with_click
			browser.quick_treeview(:name, "Input_treeview").quick_treeitem(:text, "Copy").should_not be_visible
		end
		
		it 'raises exception' do
			#browser.close_dialog("Input Manager Dialog").should close_dialog
			lambda { browser.quick_treeview(:name, "Input_treeview").quick_treeitem(:text, "Copy").expand_with_click }.should raise_error OperaWatir::DesktopExceptions::WidgetNotVisibleException
		end

		after(:all) do
			browser.close_all_dialogs
		end
  end

  describe '#expand_with_double_click' do
	
	before(:each) do
		browser.open_window_with_key_press("Bookmarks Panel Window", "b", :ctrl, :shift).should > 0
		browser.quick_treeview(:name, "Bookmarks Folders View").focus_with_click
		browser.quick_window(:name, "Bookmarks Panel Window").quick_treeview(:name, "Bookmarks View").quick_treeitem(:text, "Opera").focus_with_click
	end
	
	it 'expand with double click' do
		browser.quick_window(:name, "Bookmarks Panel Window").quick_treeview(:name, "Bookmarks View").quick_treeitem(:text, "Opera").expand_with_double_click
		browser.quick_window(:name, "Bookmarks Panel Window").quick_treeview(:name, "Bookmarks View").quick_treeitem(:text, "http://www.opera.com/download/").should be_visible
	end
	
	
	it 'collapse with double clik' do
		browser.quick_window(:name, "Bookmarks Panel Window").quick_treeview(:name, "Bookmarks View").quick_treeitem(:text, "Opera").expand_with_double_click
		browser.quick_window(:name, "Bookmarks Panel Window").quick_treeview(:name, "Bookmarks View").quick_treeitem(:text, "Opera").collapse_with_double_click
		#browser.quick_window(:name, "Bookmarks Panel Window").quick_treeview(:name, "Bookmarks View").quick_treeitem(:text, "http://my.opera.com/").visible?.should == false

	end
	
	it 'Raises Exceptions' do
		#browser.quick_window(:name, "Bookmarks Panel Window").quick_treeview(:name, "Bookmarks View").quick_treeitem(:text, "Opera").key_press("Del")
		#lambda { browser.quick_window(:name, "Bookmarks Panel Window").quick_treeview(:name, "Bookmarks View").quick_treeitem(:text, "Opera").expand_with_double_click }.should raise_error OperaWatir::DesktopExceptions::WidgetNotVisibleException
	end
	
	after(:each) do
		browser.close_all_tabs
		browser.close_all_dialogs
	end
	
  end
    
   # alias_method :collapse_with_double_click, :expand_with_double_click
    
  describe '#key_press(key, *opts)' do
	
	it "key press with modifiers" do
		browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").focus_with_click
		browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").clear
		browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").type_text("opera:config").should == "opera:config"
		#browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").key_press("Enter")
		browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").key_press("a", :ctrl)
		browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").key_press("c", :ctrl)
		browser.open_window_with_key_press("Document Window", "t", :ctrl).should > 0
		browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").focus_with_click
		browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").key_press("v", :ctrl)
		browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").text.should == "opera:config"
	end
	
	after(:all) do
		browser.close_all_tabs
	end
	
  end
        
  describe '#selected?' do
  end
     
  describe '#activate_tab_with_click' do
  end
    
  describe '#open_window_with_double_click(win_name)' do
  end
    
   # alias_method :open_dialog_with_double_click, :open_window_with_double_click
    
  #private
  describe '#scroll_item_into_view' do
  end
  
  
end

