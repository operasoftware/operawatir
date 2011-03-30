require File.expand_path('../../watirspec_desktophelper', __FILE__)
require File.expand_path('../shared/shared', __FILE__)

describe 'QuickSearchField' do
  
  let(:widget) { browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_searchfield(:name, "tbs_MainSearch") }
   subject { widget }
     
   it_behaves_like "a widget"
   it_behaves_like "an editfield"
   
  its(:type) { should == :search }
   
  describe '#quick_searchfield' do
    it 'constructs searchfield by its name' do
      browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_searchfield(:name, "tbs_MainSearch").should exist
    end
  end
   
  describe '#search_with_text' do
    it 'returns text in address field after loading of page' do
      browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_searchfield(:name, "tbs_MainSearch").search_with_text("old cars").should include "http://www.google.no/search"
    end
  end
  
end