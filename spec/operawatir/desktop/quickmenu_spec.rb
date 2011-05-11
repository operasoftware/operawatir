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
    before(:all) do
      # 1. Rightclick in address field
      addressfield.open_menu_with_rightclick("Toolbar Edit Item Popup Menu").should open_menu
    end
    after(:all) do
      addressfield.right_click
    end
    
    it 'constructs a menu by its name' do
      browser.quick_menu(:name, "Toolbar Edit Item Popup Menu").should exist
      browser.quick_menu(:name, "Toolbar Edit Item Popup Menu").click
      #sleep(2)
    end
  
    describe '#quick_menus' do
      it 'lists all menus' do
        #Just to test more than main menu :)
        #addressfield.open_menu_with_rightclick("Toolbar Edit Item Popup Menu").should open_menu
        browser.quick_menus.each do |menu|
          puts menu.to_s
        end
      end
    end

=begin    
    describe 'opening a rightclick menu from link in webpage' do
      it 'works' do
        browser.goto(WatirSpec.files + "/non_control_elements.html")
        browser.link(:id, 'link_2').right_click
      end
    end
=end


  
  end
end


#######################################

describe 'QuickButton' do
  let(:menubutton) { browser.quick_window(:name, "Browser Window").quick_toolbar(:name, "Pagebar Head").quick_button(:name, "tbb_MenuButton") }
  let(:menubar) { browser.quick_menu(:name, "Main Menu")}
  describe 'open_menu_with_click' do
    before(:each) do
      unless menubutton.exists? 
        menubar.quick_menuitem(:name, "Browser File Menu").open_menu_with_click("Browser File Menu").should open_menu
        browser.quick_menu(:name, "Browser File Menu").quick_menuitem(:action, "Enable menu bar").click
      end
    end
    it 'opens a menu' do
      menubutton.open_menu_with_click("Browser Button Menu Bar").should open_menu 
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
