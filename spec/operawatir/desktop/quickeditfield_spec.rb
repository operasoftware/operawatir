require File.expand_path('../../watirspec_desktophelper', __FILE__)
require File.expand_path('../shared/shared', __FILE__)


describe 'QuickEditField' do

	before(:all) do
		browser.open_dialog_with_action("New Preferences Dialog", "Show preferences", 1).should > 0
	end
  
	after(:all) do
		browser.close_all_tabs
		browser.close_all_dialogs
	end
	
	let(:url1) { "http://t/platforms/desktop/automated/resources/documents/page1.html" }
	let(:url2) { "http://t/platforms/desktop/automated/resources/documents/page2.html" }
  
	let(:widget) { browser.quick_editfield(:name, "Firstname_edit") }
	subject { widget }
    
	it_behaves_like 'a widget'
	it_behaves_like 'an editfield'
  
	its(:type) { should == :editfield }


    describe '#load_page_with_key_press(key, *modifiers)' do
		it "presses a single key" do
			browser.close_all_dialogs
			browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").focus_with_click
			browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").clear
			browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").type_text(url1).should == url1
			browser.load_page_with_key_press("Enter").should > 0
			browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").text.should == url1
			browser.quick_window(:name, "Browser Window").quick_toolbar(:name, "Pagebar").quick_tab(:name, "Tab 0").text.should == "Test Page 1"
		end	
    end


=begin # it is a private method
    describe '#enter_text_and_hit_enter(text)' do
		it "type text and press enter in the same method" do
			browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").focus_with_click
			browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").clear
			browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").enter_text_and_hit_enter(url2).should == url2
			browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").text.should == url2
			browser.quick_window(:name, "Browser Window").quick_toolbar(:name, "Pagebar").quick_tab(:name, "Tab 0").text.should == "Test Page 2"
		end
      
	  
	  
    end
=end

end