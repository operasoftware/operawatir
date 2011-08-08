require File.expand_path('../../watirspec_desktophelper', __FILE__)
require File.expand_path('../shared/shared', __FILE__)

describe 'QuickMenu' do
  let(:addressfield) { browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field") }
  let(:menu) { browser.quick_menu(:name, "Toolbar Edit Item Popup Menu") }
    
  subject { menu }
    
  before(:each) do
    addressfield.open_menu_with_rightclick("Toolbar Edit Item Popup Menu").should open_menu
  end
  after(:each) do
    browser.close_all_menus
  end
      
  its(:name) { should_not be_empty }
  its(:window_id) { should be_kind_of Integer }
  its(:to_s) { should_not be_empty } #should == menu.element.toString() 
  its(:width) { should be_kind_of Integer }
  its(:height)  { should be_kind_of Integer }
  its(:x) { should be_kind_of Integer }
  its(:y) { should be_kind_of Integer }
  
  describe '#exists'do
    it 'should return true' do
      menu.should exist
    end
  end
  
  describe '#parentmenu?' do
    it 'should return true or false' do
      menu.should be_parentmenu
    end
  end

  describe '#quick_menu' do
    it 'constructs a menu by its name' do
      menu.should exist
    end
  end
      
  describe '#quick_menus' do
    it 'lists all menus' do
      browser.quick_menus.should_not be_empty
    end
  end
  
  describe '#quick_menuitems' do
    it 'lists menuitems in this menu' do
      puts menu.quick_menuitems
      menu.quick_menuitems.select { |item| item.menu != menu.name }.should be_empty
      menu.quick_menuitems.select { |item| item.menu == menu.name }.should_not be_empty
      menu.quick_menuitems.select { |item| item.submenu_item? == true }.should_not be_empty
    end
  end
end
