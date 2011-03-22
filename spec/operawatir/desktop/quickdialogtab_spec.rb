require File.expand_path('../../watirspec_desktophelper', __FILE__)
require File.expand_path('../shared/shared', __FILE__)

describe 'QuickDialogTab' do

	let(:url1) { "http://t/platforms/desktop/automated/resources/documents/page1.html" }
	let(:url2) { "http://t/platforms/desktop/automated/resources/documents/page2.html" }
  
  let(:widget) { browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar")  .quick_button(:name, "tbb_Home") }
  subject { widget }
    
  it_behaves_like "a widget"

  describe '#activate_tab_with_click' do
	 it 'activates a tab with click' do
	   browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").load_page_with_url(url1).should == url1
	   browser.load_window_with_action("Document Window", "Open url in new page", url2).should > 0
	   browser.quick_window(:name, "Browser Window").quick_toolbar(:name, "Pagebar").quick_tab(:name, "Tab 0").activate_tab_with_click
	   browser.quick_window(:name, "Browser Window").quick_toolbar(:name, "Pagebar").quick_tab(:name, "Tab 0").text.should == "Test Page 1"
	   browser.quick_window(:name, "Browser Window").quick_toolbar(:name, "Pagebar").quick_tab(:name, "Tab 1").activate_tab_with_click
	   browser.quick_window(:name, "Browser Window").quick_toolbar(:name, "Pagebar").quick_tab(:name, "Tab 1").text.should == "Test Page 2"
	 end
  end
  
 
 
end

