require File.expand_path('../../watirspec_desktophelper', __FILE__)
require File.expand_path('../shared/shared', __FILE__)

describe 'QuickMenuItem' do
  
  #button#open_menu_with_click
  # open_right_click_menu / open_menu_with_right_click (button#, treeitem#, link#, ..)

  let(:addressfield) { browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field") }

  after(:all) { addressfield.right_click }
    
  #browser.quick_menu(:name, "Image Popup Menu").quick_menuitem(:string_id, ID) #Tiresome to look up
  #browser.quick_menu(:name, "Image Popup Menu").quick_menuitem(:shortcut, ..)#Not platform independent 
    
  describe '#quick_menuitem' do
    it 'constructs a menu item by its action name' do
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
      browser.quick_menu(:name, "Toolbar Edit Item Popup Menu").quick_menuitem(:acckey, "r").should exist
    end
    
    it 'constructs a menu item by its shortcut'
    it 'constructs a menu item by its string_id'
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
  
=begin    
  before(:each) do
    # 1. Rightclick in address field
    addressfield.open_menu_with_rightclick("Toolbar Edit Item Popup Menu").should open_menu
  end
  after(:each) do
    addressfield.focus_with_click
  end

  describe '#close_menu_with_click' do
    it 'closes menu' do
      #puts "------ Output of close_menu: " + browser.quick_menu(:name, "Toolbar Edit Item Popup Menu").quick_menuitem(:action, "Select all").close_menu_with_click("Toolbar Edit Item Popup Menu")
      browser.quick_menu(:name, "Toolbar Edit Item Popup Menu").quick_menuitem(:action, "Delete").close_menu_with_click("Toolbar Edit Item Popup Menu").should close_menu
      #addressfield.key_press("enter")
    end
  end


  describe '#click' do
    it 'closes menu' do
      browser.quick_menu(:name, "Toolbar Edit Item Popup Menu").quick_menuitem(:action, "Select all").click#.should close_menu
      #TODO: Check menu is closed
    end
  end
=end
  
=begin  
  describe 'open_menu_with_hover' do
   
    it 'opens submenu' do
      puts "OPEN_MENU_WITH_HOVER ------------------------------"
      menu.quick_menuitem(:submenu, "Toolbar Popup Customize Menu").open_menu_with_hover("Toolbar Popup Customize Menu").should open_menu
    #end
    
    #it 'closes menu' do
      sleep(5)
      puts " OPEN DIALOG WITH CLICK ------------------------------"
      submenu.quick_menuitem(:action, "Customize Toolbars").open_dialog_with_click("Customize Toolbar Dialog").should > 0
      #submenu.quick_menuitem(:action, "Customize Toolbars").close_menu_with_click("Toolbar Popup Customize Menu").should close_menu
    end
    
  end
end  
=end
  describe 'QuickMenuItem' do

  describe '#load_page_with_click' do
    it 'loads a page (from bookmark)' do
      menubutton.open_menu_with_click("Browser Button Menu Bar").should open_menu
      mainmenu.quick_menuitem(:submenu, "Browser Bookmarks Menu").open_menu_with_hover("Browser Bookmarks Menu").should open_menu
      bookmarksmenu.quick_menuitem(:text, "Kayak").load_page_with_click.should be > 0
    end
  end

  describe '#open_window_with_click' do
    it 'opens window (Downloads tab)' do
      browser.quick_widgets("Browser Window").each do |w|
        puts w.to_s
      end
      
      menubutton.open_menu_with_click("Browser Button Menu Bar").should open_menu
      
      # TODO, WhatToDo, more actions with same action, different params ...
      mainmenu.quick_menuitem(:text, "Downloads").open_window_with_click("Transfers Panel Window").should open_window
    end
  end

   
    describe '#quick_menuitems' do
      #before:enable menubar?
      it 'lists menuitems' do
        #addressfield.open_menu_with_rightclick("Toolbar Edit Item Popup Menu").should open_menu
        puts browser.quick_menuitems
        #browser.quick_menuitems.each do |item|
        #   puts item.to_s
        #end
        #browser.quick_menuitems.
      end
    end


    describe '#open_window_with_click using main menu bar' do
      before(:each) do
        #enable menubar
        if menubutton.exists? 
          menubutton.open_menu_with_click("Browser Button Menu Bar").should open_menu
          mainmenu.quick_menuitem(:action, "Enable menu bar").click
        end
      end
      it 'opens window (Downloads tab)' do
        browser.quick_windows.each do |win|
          #if win.type == "Browser Window"
        puts win.to_s + ", #{win.x}, #{win.y}, #{win.width}, #{win.height}"
          #end
        end
        
        menubar.quick_menuitem(:name, "Browser Tools Menu").open_menu_with_click("Browser Tools Menu").should open_menu
        
        # TODO, WhatToDo, more actions with same action, different params ...
        browser.quick_menu(:name, "Browser Tools Menu").quick_menuitem(:text, "Downloads").open_window_with_click("Transfers Panel Window").should open_window
      end
    end
  
  end
end

describe 'QuickMenuItem' do
  
  #For menuitem: Action == Name
  
  let(:widget) { browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar")  .quick_button(:name, "tbb_Home") }
  subject { widget }
  #it_behaves_like 'a widget'
  #it_behaves_like 'a button'
  #its(:type) { should == :menu_entry }
  
#=begin  
  its(:shortcut) { should be_kind_of String }
  its(:shortcutletter) { should be kind_of String }
  its(:text) { should_not be_empty }
  #its(:string_id) #??
  its(:enabled?) { should be_boolean }
  its(:selected?) { should be_boolean }
  its(:checked?) { should be_boolean }
  #its(:icon)
  #its(:rect)
#=end
  it 'should have action or submenu' do
    widget.action ? true : widget.submenu
  end
      
  describe 'position' do
    it 'returns position for menuitem in personalbar' 
    it 'can specify which menuitem to construct'
  end
  
  #hover may open a submenu
  describe 'open_menu_with_hover' do
    
  end
  
  #click invokes the action of the item
  describe 'click' do
    
  end

  describe '#open_window_with_click' do
    it 'opens a window' 
    it 'raises exception if menuitem is disabled'
  end
  
  describe '#load_page_with_click' do
    it 'returns window id'  
  end

  #describe '#value' do
end
