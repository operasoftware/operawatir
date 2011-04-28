require File.expand_path('../../watirspec_desktophelper', __FILE__)
require File.expand_path('../shared/shared', __FILE__)

describe 'QuickMenu' do
  
  #button#open_menu_with_click
  # open_right_click_menu / open_menu_with_right_click (button#, treeitem#, link#, ..)
  let(:addressfield) { browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field") }
  after(:all) {
    addressfield.right_click 
  }
    
  describe '#quick_menu' do
    #browser.quick_menu(:name, "Image Popup Menu")
    it 'constructs a menu by its action name' do
      # 1. Rightclick in address field
      addressfield.open_menu_with_rightclick("Toolbar Edit Item Popup Menu").should open_menu
      
      # 2.
      browser.quick_menu(:name, "Toolbar Edit Item Popup Menu").should exist
      browser.quick_menu(:name, "Toolbar Edit Item Popup Menu").quick_menuitem(:action, "Clear").should exist
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
  
  #Submenu 
  
end

#######################################
#Added here for now until we have menus support
describe 'QuickButton' do
  let(:menubutton) { browser.quick_window(:name, "Browser Window").quick_toolbar(:name, "Pagebar Head").quick_button(:name, "tbb_MenuButton") }
  describe 'open_menu_with_click' do
    it 'opens a menu' do
      menubutton.open_menu_with_click("").should open_menu 
    end
  end
  describe 'open_menu_with_long_click' do
    it 'opens a menu'
  end
end

describe 'DesktopBrowser' do
  describe 'open_menu_with_key_press' do
    it 'opens a menu'
  end
  
  #Web page ..., Addressfield, .... Anywhere ...
  describe 'open_menu_with_right_click' do
    it 'opens rightclick menu'
  end
end
####################################

describe 'QuickMenuItem' do
  
  #For menuitem: Action == Name
  
  #browser.quick_menu(:name, "Image Popup Menu").quick_menuitem(:pos, 1) # Not platform independent
  #browser.quick_menu(:name, "Image Popup Menu").quick_menuitem(:string_id, ID) #Tiresome to look up
  #browser.quick_menu(:name, "Image Popup Menu").quick_menuitem(:text, ..) #Not language independent
  #browser.quick_menu(:name, "Image Popup Menu").quick_menuitem(:action, ..) #Language independent
  #browser.quick_menu(:name, "Image Popup Menu").quick_menuitem(:shortcut, ..)#Not platform independent 

  #let(:widget) { browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar")  .quick_button(:name, "tbb_Home") }
  #subject { widget }
  #it_behaves_like 'a widget'
  #it_behaves_like 'a button'
  #its(:type) { should == :menu_entry }
  
=begin  
  its(:shortcut) { should be_kind_of String }
  its(:shortcutletter) { should be kind_of String }
  its(:text) { should_not be_empty }
  #its(:string_id) #??
  #its(:action)
  #its(:submenu)
  its(:enabled?) { should be_boolean }
  its(:selected?) { should be_boolean }
  its(:checked?) { should be_boolean }
  #its(:icon)
  #its(:rect)
=end  
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
