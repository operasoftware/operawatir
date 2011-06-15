require File.expand_path('../../watirspec_desktophelper', __FILE__)
require File.expand_path('../shared/shared', __FILE__)

describe 'QuickMenu' do
  let(:addressfield) { browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field") }
  let(:menu) { browser.quick_menu(:name, "Toolbar Edit Item Popup Menu") }
    
  subject { menu }
    
  before(:all) do
    addressfield.open_menu_with_rightclick("Toolbar Edit Item Popup Menu").should open_menu
  end
  after(:all) do
    addressfield.click
  end
      
  #its(:type) { should == :menu }
  its(:name) { should_not be_empty }
  its(:window_id) { should be_kind_of Integer }
  #its(:to_s) { should == menu.element.toString() }
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
      #Just to test more than main menu :)
      addressfield.open_menu_with_rightclick("Toolbar Edit Item Popup Menu").should open_menu
      browser.quick_menus.should_not be_empty
    end
  end
  
  #describe '#menuitems' do
  #  it 'lists menuitems in this menu' do
  #    menu.menuitems.select { |item| item.menu != name }.should be_empty
  #    menu.menuitems.select { |item| item.menu == name }.should_not be_empty
  #    menu.menuitems.select { |item| item.submenu? == true }.should_not be_empty
  #  end
  #end

=begin    
    describe 'opening a rightclick menu from link in webpage' do
      it 'works' do
        browser.goto(WatirSpec.files + "/non_control_elements.html")
        browser.link(:id, 'link_2').right_click
      end
    end
=end
end