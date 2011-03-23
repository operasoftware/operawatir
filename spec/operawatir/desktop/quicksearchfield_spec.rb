require File.expand_path('../../watirspec_desktophelper', __FILE__)
require File.expand_path('../shared/shared', __FILE__)

describe 'QuickSearchField' do
  
  let(:widget) { browser.quick_window(:name, "Document Window").quick_toolbar(:name, "Document Toolbar").quick_searchfield(:name, "tbs_MainSearch") }
   subject { widget }
     
   it_behaves_like "a widget"
   it_behaves_like "an editfield"
   
  describe '#quick_searchfield' do
    it 'constructs searchfield by its name'
  end
   
  describe '#search_with_text' do
    #Note: This will fail (cf. DSK-328699)
    it 'returns text in address field after loading of page'
  end
  
end