require File.expand_path('../../watirspec_desktophelper', __FILE__)
require File.expand_path('../shared/shared', __FILE__)

describe 'QuickButton' do

	let(:url) { "http://t/platforms/desktop/automated/resources/documents/page1.html" }
	let(:url2) { "http://t/platforms/desktop/automated/resources/documents/page2.html" }
  
  let(:widget) { browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar")  .quick_button(:name, "tbb_Stop_Reload") }
  subject { widget }
    
  it_behaves_like 'a widget'
  it_behaves_like 'a button'
  
  its(:type) { should == :button }
  
  describe '#quick_button' do
    it "constructs a button by its name" do
		browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar")
	end
  end
  
  after(:all) do
    browser.close_all_tabs
  end
  
  describe 'position' do
    before(:all) do
      browser.open_dialog_with_action("Customize Toolbar Dialog", "Customize Toolbars")
      browser.quick_dialogtab(:name, "tab_appearance_toolbars").activate_tab_with_click
      bookmarks = browser.quick_checkbox(:name, "bookmarks_bar")
      bookmarks.toggle_with_click unless bookmarks.value == 1
      browser.close_dialog("Customize Toolbar Dialog")
    end
    after(:all) do
      browser.open_dialog_with_action("Customize Toolbar Dialog", "Customize Toolbars")
      browser.quick_dialogtab(:name, "tab_appearance_toolbars").activate_tab_with_click
      browser.quick_checkbox(:name, "bookmarks_bar").toggle_with_click
      browser.close_dialog("Customize Toolbar Dialog")
    end
    it 'returns position for button in personalbar' do 
      browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Personalbar Inline").quick_button(:text, "Kayak").position >= 0
    end
    it "can specify which button to construct" do
      browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Personalbar Inline").quick_button(:pos, 1).should exist
    end
  end

  #This is already in shared for a button
  describe '#default?' do
		before(:each) do
			browser.open_dialog_with_action("New Preferences Dialog", "Show preferences").should > 0
	 	end
		
    after(:each) do
			browser.close_dialog("New Preferences Dialog").should > 0
		end
		
		it 'returns true for default button' do
			browser.quick_button(:name, "button_OK").should be_default
		end
		
		it 'returns false for non-default button' do
			browser.quick_button(:name, "button_Cancel").should_not be_default
		end
  end

  describe '#open_window_with_click' do
=begin    
		it 'a click does not open any windows' do
			browser.open_window_with_key_press("Document Window", "t", :ctrl).should > 0
			browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").quick_button(:name, "af_ProtocolButton").open_window_with_click("Addressbar Overlay Window").should_not open_window
		end
=end		
		it 'opens a window' do
			browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").load_page_with_url(url).should == url
			browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").quick_button(:name, "af_ProtocolButton").open_window_with_click("Addressbar Overlay Window").should open_window
		end
		
		it 'raises exception for not visible button' do
			browser.open_dialog_with_action("Customize Toolbar Dialog", "Customize Toolbars").should open_dialog
			browser.quick_dialogtab(:name, "tab_appearance_toolbars").activate_tab_with_click
			if browser.quick_checkbox(:name, "address_bar").checked? == true
				browser.quick_checkbox(:name, "address_bar").toggle_with_click.should == false
			end
			browser.quick_button(:name, "button_OK").close_dialog_with_click("Customize Toolbar Dialog").should close_dialog
			expect { browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").quick_button(:name, "af_ProtocolButton").open_window_with_click("Addressbar Overlay Window") }.to raise_error OperaWatir::DesktopExceptions::WidgetNotVisibleException
		end
		
		after(:all) do
			browser.open_dialog_with_action("Customize Toolbar Dialog", "Customize Toolbars").should open_dialog
			browser.quick_dialogtab(:name, "tab_appearance_toolbars").activate_tab_with_click
			if browser.quick_checkbox(:name, "address_bar").checked? == false
				browser.quick_checkbox(:name, "address_bar").toggle_with_click.should == true
			end
			browser.quick_button(:name, "button_OK").close_dialog_with_click("Customize Toolbar Dialog").should close_dialog
		end
  end
  
  describe '#change_page_with_click' do
	
		before(:each) do
			browser.open_dialog_with_action("New Account Wizard", "New account").should > 0
		end
		
		it 'changes dialog to a different page' do
			browser.quick_button(:name, "button_Next").change_page_with_click.should > 0
			browser.close_dialog("New Account Wizard").should > 0
		end
=begin		
		it 'returns 0 - no new page is loaded ' do
			browser.quick_button(:name, "button_Cancel").change_page_with_click.should == 0
		end
=end		
  end
  
  describe '#close_window_with_click' do
		it 'raises exception' do
			browser.open_dialog_with_action("Clear Private Data Dialog", "Delete private data").should > 0
			browser.quick_button(:name, "button_manage_cookies").visible?.should == false
			lambda { browser.quick_button(:name, "button_manage_cookies").close_window_with_click("")}.should raise_error OperaWatir::DesktopExceptions::WidgetNotVisibleException
			browser.close_dialog("Clear Private Data Dialog").should > 0
		
		end
	
		it 'returns window id of closed dialog window' do
			browser.open_dialog_with_action("Add Bookmark Dialog", "Add to bookmarks").should > 0
			browser.quick_button(:name, "button_Cancel").close_dialog_with_click("Add Bookmark Dialog").should > 0
		end
    
		it 'returns window id of closed window' do
			browser.open_window_with_key_press("Document Window", "t", :ctrl).should > 0
			browser.quick_window(:name, "Browser Window").quick_toolbar(:name, "Pagebar").quick_tab(:name, "Tab 1").quick_button(:name, "pb_CloseButton").close_window_with_click("Document Window").should > 0
		end
  end
  
  describe '#load_page_with_click' do
		it 'returns window id' do
			browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").load_page_with_url(url).should == url
			browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").load_page_with_url(url2).should == url2
			browser.quick_toolbar(:name, "Document Toolbar").quick_button(:name, "tbb_Back").load_page_with_click.should > 0
		end
=begin		
		it 'returns 0 - no windows is open' do
			browser.open_window_with_key_press("Document Window", "t", :ctrl).should open_window
			browser.quick_toolbar(:name, "Document Toolbar").quick_button(:name, "tbb_Stop_Reload").load_page_with_click.should == 0
			browser.close_window_with_key_press("Document Window", "w", :ctrl).should close_window
		end
=end		
  end
    
  describe '#toggle_with_click' do
		
		before(:all) do
			browser.open_dialog_with_action("Clear Private Data Dialog", "Delete private data").should open_dialog
		end
		
		it 'returns value = 1 of button when button is pressed' do
			browser.quick_button(:name, "Destails_expand").toggle_with_click.should == 1
		end
		
		it 'returns value = 0 of button when button is unpressed' do
			browser.quick_button(:name, "Destails_expand").toggle_with_click.should == 0
			browser.close_dialog("Clear Private Data Dialog").should close_dialog
		end
		
		it "returns false when it removes a button" do #New in Task 5
			browser.open_window_with_key_press("Document Window", "t", :ctrl).should > 0
			browser.quick_window(:name, "Document Window").quick_thumbnail(:name, name).quick_button(:name, "tb_CloseButton").toggle_with_click
		end
		

  end

  describe '#close_toolbar_with_click' do
  end

  describe '#expand_with_click' do
	
		before(:all) do
			browser.open_dialog_with_action("Clear Private Data Dialog", "Delete private data").should open_dialog
		end
	
		it 'expands dialog with click' do
			browser.quick_button(:name, "Destails_expand").expand_with_click
			browser.quick_button(:name, "button_manage_wand").should be_visible
		end
		

		it 'collapses dialog with click ' do
			browser.quick_button(:name, "Destails_expand").expand_with_click
			browser.quick_button(:name, "button_manage_wand").should_not be_visible
		end
		
		it 'raises exception when button is not visible' do
			lambda { browser.quick_button(:name, "button_manage_wand").expand_with_click }.should raise_error OperaWatir::DesktopExceptions::WidgetNotVisibleException
		end
		
		after(:all) do
			browser.close_dialog("Clear Private Data Dialog").should close_dialog
		end
  end

  describe '#value' do
	
		before(:all) do
			browser.open_dialog_with_action("Clear Private Data Dialog", "Delete private data").should open_dialog
		end
		
		it 'returns 1 when button is pressed' do
			browser.quick_button(:name, "Destails_expand").toggle_with_click.should == 1
			browser.quick_button(:name, "Destails_expand").value.should == 1
		end
		
		it 'returns 0 when button is unpressed' do
			browser.quick_button(:name, "Destails_expand").toggle_with_click.should == 0
			browser.quick_button(:name, "Destails_expand").value.should == 0
		end
		
		after(:all) do
			browser.close_dialog("Clear Private Data Dialog")
		end
  end

  describe '#close_toolbar_with_click' do
		before(:each) do
			browser.quick_window(:name, "Browser Window").quick_toolbar(:name, "Status Toolbar Head").quick_button(:name, "tbb_Panel").toggle_with_click
		end
		
		it 'closes toolbar' do
      browser.quick_window(:name, "Browser Window").quick_toolbar(:name, "Hotlist Panel Selector").should be_visible
			browser.quick_window(:name, "Browser Window").quick_toolbar(:name, "Status Toolbar Head").quick_button(:name, "tbb_Panel").close_toolbar_with_click
			browser.quick_window(:name, "Browser Window").quick_toolbar(:name, "Hotlist Panel Selector").should_not be_visible
		end
		
  end
  
  describe '#wait_for_enabled' do
    after(:each) do
      browser.close_all_dialogs
    end
		it 'returns true when button is enabled' do
			browser.open_dialog_with_url("Setup Apply Dialog Confirm Dialog", "http://t/platforms/desktop/bts/DSK-311302/keyboard.ini").should > 0
			browser.quick_button(:name, "button_OK").wait_for_enabled.should be_true
			browser.quick_button(:name, "button_OK").should be_enabled
		end
=begin		
		it 'returns false' do
			browser.open_dialog_with_action("Customize Toolbar Dialog", "Customize Toolbars").should open_dialog
			browser.quick_dialogtab(:name, "tab_appearance_buttons").activate_tab_with_click
			browser.quick_treeview(:name, "Buttons_treeview").quick_treeitem(:string_id, "D_CUSTOMIZE_TOOLBAR_DEFAULTS").focus_with_click
			browser.quick_button(:name, "Reset button").wait_for_enabled.should be_false
			browser.quick_button(:name, "Reset button").enabled?.should be_false
			browser.close_dialog("Customize Toolbar Dialog").should close_dialog
		end
=end    
  end
end

describe 'QuickButton' do
  let(:menubutton) { browser.quick_window(:name, "Browser Window").quick_toolbar(:name, "Pagebar Head").quick_button(:name, "tbb_MenuButton") }
  let(:menubar)    { browser.quick_menu(:name, "Main Menu")}
    
  describe 'open_menu_with_click' do
    before(:each) do
      unless menubutton.exists? 
        menubar.quick_menuitem(:name, "Browser File Menu").open_menu_with_click("Browser File Menu").should open_menu
        browser.quick_menu(:name, "Browser File Menu").quick_menuitem(:action, "Enable menu bar").toggle_with_click
      end
    end
    it 'opens a menu' do
      menubutton.open_menu_with_click("Browser Button Menu Bar").should open_menu 
    end
  end
  
  #We don't support longclick yet
  describe 'open_menu_with_long_click' do
    it 'opens a menu'
  end
end

