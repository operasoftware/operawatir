require File.expand_path('../../watirspec_desktophelper', __FILE__)
require File.expand_path('../shared/shared', __FILE__)

describe 'QuickMenu' do
  
  #button#open_menu_with_click
  # open_right_click_menu / open_menu_with_right_click (button#, treeitem#, link#, ..)
  
  describe '#quick_menu' do
    #browser.quick_menu(:name, "Image Popup Menu")
    it 'constructs a menu by its name'
  end
  
  #Submenu 
  
end

#######################################
#Added here for now until we have menus support
describe 'QuickButton' do
  describe 'open_menu_with_click' do
    it 'opens a menu'
  end
  describe 'open_menu_with_long_click' do
    it 'opens a menu'
  end
end

describe 'DesktopBrowser' do
  describe 'open_menu_with_key_press' do
    it 'opens a menu'
  end
  
  #Web page ...
  describe 'open_menu_with_right_click' do
    it 'opens rightclick menu'
  end
end
####################################

describe 'QuickMenuItem' do
  
  #browser.quick_menu(:name, "Image Popup Menu").quick_menuitem(:pos, 1) # Not platform independent
  #browser.quick_menu(:name, "Image Popup Menu").quick_menuitem(:string_id, ID) #Tiresome to look up
  #browser.quick_menu(:name, "Image Popup Menu").quick_menuitem(:text, ..) #Not language independent

  #let(:widget) { browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar")  .quick_button(:name, "tbb_Home") }
  #subject { widget }
  #it_behaves_like 'a widget'
  #it_behaves_like 'a button'
  #its(:type) { should == :menu_entry }
  
  describe '#quick_menutitem' do
    it 'constructs a menuitem by its name' 
  end
  
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
