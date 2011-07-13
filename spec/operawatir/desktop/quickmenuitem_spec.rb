require File.expand_path('../../watirspec_desktophelper', __FILE__)
require File.expand_path('../shared/shared', __FILE__)

describe 'QuickMenuItem' do
  
  let(:addressfield) { browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field") }
  let(:menuitem) { browser.quick_menuitem(:name, "Clear") }
    
  before(:all) { addressfield.open_menu_with_rightclick("Toolbar Edit Item Popup Menu") }
  after(:all) { browser.close_all_menus }
    
  subject { menuitem }
 
    its(:shortcut) { should be_kind_of(String) }
    its(:shortcutletter) { should be_kind_of String }
    its(:text) { should_not be_empty }
    its(:enabled?) {should be_true }
    its(:checked?) { should be_false } 
    its(:pos) { should be_kind_of Integer }
    its(:name) { should_not be_empty }
    its(:menu) { should == "Toolbar Edit Item Popup Menu" }
    its(:separator?) { should be_false }
    its(:bold?) { should be_false }
    its(:action_item?) { should be_true }
    its(:submenu_item?) {should be_false }
    its(:action_params) { should be_empty }
    its(:submenu) { should be_empty }
    its(:width) { should be_kind_of Integer }
    its(:height) { should be_kind_of Integer }
    its(:x) { should be_kind_of Integer }
    its(:y) { should be_kind_of Integer }
    its(:to_s) { should_not be_empty } 
    
    describe '#open_window_with_click' do
      it 'opens a window' 
      it 'raises exception if menuitem is disabled'
    end
    
    describe '#toggle_with_click' do
      it 'toggles checkbox of menuitem'  
    end

    
  describe '#quick_menuitem' do
    it 'constructs a menu item by its action name' do
      browser.quick_menu(:name, "Toolbar Edit Item Popup Menu").should exist
      browser.quick_menu(:name, "Toolbar Edit Item Popup Menu").quick_menuitem(:action, "Clear").should exist
    end
   
    it 'constructs a menu item by its submenu name' do
      browser.quick_menu(:name, "Toolbar Edit Item Popup Menu").quick_menuitem(:submenu, "Toolbar Popup Customize Menu").should exist
    end
    
    it 'constructs a menu item by its text' do
      browser.quick_menu(:name, "Toolbar Edit Item Popup Menu").quick_menuitem(:text, "Clear All").should exist
    end
    
    it 'constructs a menu item by its position (row)' do
      browser.quick_menu(:name, "Toolbar Edit Item Popup Menu").quick_menuitem(:pos, 1).should exist
    end
    
    it 'constructs a menu item by its shortcutletter' do
      browser.quick_menu(:name, "Toolbar Edit Item Popup Menu").quick_menuitem(:acckey, "R").should exist
    end
    
    it 'constructs a menu item by its shortcut' do
      browser.quick_menu(:name, "Toolbar Edit Item Popup Menu").quick_menuitem(:shortcut, "Ctrl+V").should exist
    end
    
    it 'constructs a menuitem by its stringId' do
      browser.quick_menu(:name, "Toolbar Edit Item Popup Menu").quick_menuitem(:string_id, "MI_IDM_EDIT_UNDO").should exist
    end

  end    
end

describe 'QuickMenuItem' do
  let(:addressfield) { browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field") }
  let(:menu) { browser.quick_menu(:name, "Toolbar Edit Item Popup Menu") }
  let(:submenu) { browser.quick_menu(:name, "Toolbar Popup Customize Menu")}
  
  before(:each) do
    addressfield.open_menu_with_rightclick("Toolbar Edit Item Popup Menu").should open_menu
  end

  after(:each) do
    browser.close_all_menus
    browser.close_all_dialogs
  end

  #describe '#close_menu_with_key_press' do
  #  it 'closes menu' #do
      #browser.quick_menu(:name, "Toolbar Edit Item Popup Menu").quick_menuitem(:action, "Delete").close_menu_with_key_press("Toolbar Edit Item Popup Menu", "Esc").should close_menu
  #  end
  #end
  
  describe '#open_menu_with_hover' do
    it 'opens submenu' do
      menu.quick_menuitem(:submenu, "Toolbar Popup Customize Menu").open_menu_with_hover("Toolbar Popup Customize Menu").should open_menu
      submenu.quick_menuitem(:action, "Customize Toolbars").open_dialog_with_click("Customize Toolbar Dialog").should > 0
      #submenu.quick_menuitem(:action, "Customize Toolbars").close_menu_with_click("Toolbar Popup Customize Menu").should close_menu
    end
  end
  
  describe '#close_menu_with_click' do
    it 'closes menu'
  end

end  

  describe 'QuickMenuItem' do
    let(:addressfield) { browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field") }
    let(:menu) { browser.quick_menu(:name, "Toolbar Edit Item Popup Menu") }
    let(:submenu) { browser.quick_menu(:name, "Toolbar Popup Customize Menu")}
    let(:mainmenu) { browser.quick_menu(:name, "Browser Button Menu Bar")}
      
    let(:menubutton) { browser.quick_window(:name, "Browser Window").quick_toolbar(:name, "Pagebar Head").quick_button(:name, "tbb_MenuButton")}
    let(:bookmarksmenu) { browser.quick_menu(:name, "Browser Bookmarks Menu")}
      
    let(:menubar) {browser.quick_menu(:name, "Main Menu")}
   
  describe '#load_page_with_click' do
    it 'loads a page (from bookmark)' #do
     # menubutton.open_menu_with_click("Browser Button Menu Bar").should open_menu
     # mainmenu.quick_menuitem(:submenu, "Browser Bookmarks Menu").open_menu_with_hover("Browser Bookmarks Menu").should open_menu
     # #mainmenu.quick_menuitem(:shortcut, "B").open_menu_with_hover("Browser Bookmarks Menu").should open_menu
    #  bookmarksmenu.quick_menuitem(:text, "Kayak").load_page_with_click.should be > 0
  #  end
  end

  describe '#open_window_with_click' do
    it 'opens window (Downloads tab)' do
      menubutton.open_menu_with_click("Browser Button Menu Bar").should open_menu
      mainmenu.quick_menuitem(:text, "Downloads").open_window_with_click("Transfers Panel Window").should open_window
    end
	after (:all) do
		browser.close_all_tabs
	end
  end

   
    describe '#quick_menuitems' do
      #before:enable menubar?
      it 'lists menuitems' do
		addressfield.open_menu_with_rightclick("Toolbar Edit Item Popup Menu").should open_menu
        browser.quick_menuitems.should_not be_empty
      end
    end


    describe '#open_window_with_click using main menu bar' do
      before(:each) do
        #enable menubar
        if menubutton.exists? 
          menubutton.open_menu_with_click("Browser Button Menu Bar").should open_menu
          mainmenu.quick_menuitem(:action, "Enable menu bar").toggle_with_click
        end
      end
      
      it 'opens window (Downloads tab)' do
        menubar.quick_menuitem(:name, "Browser Tools Menu").open_menu_with_click("Browser Tools Menu").should open_menu
        
        browser.quick_menu(:name, "Browser Tools Menu").quick_menuitem(:text, "Downloads").open_window_with_click("Transfers Panel Window").should open_window
      end
    end
end


