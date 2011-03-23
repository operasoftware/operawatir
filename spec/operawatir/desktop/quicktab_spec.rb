require File.expand_path('../../watirspec_desktophelper', __FILE__)
require File.expand_path('../shared/shared', __FILE__)

describe 'QuickTab' do
  
   let(:widget) { browser.quick_window(:name, "Browser Window").quick_toolbar(:name, "Pagebar").quick_tab(:name, "Tab 0") }
  
   subject { widget }
     
   it_behaves_like "a widget"
   it_behaves_like "a button"
   
  describe "#quick_tab" do
    it "constructs tabbutton by its position"
    it "constructs tabbutton by its name"
    it "constructs tabbutton by its text"
  end
  
  describe '#move_with_drag' do
    describe 'when target is not a tab' do
      it 'raises UnknownObjectException'
    end
  end

  #Note this part of api will probably change when new tab grouping is handled
  describe '#group_with_drag' do
    it 'raises UnknownObjectException if target is not a tab'
    it 'returns the number of tabs in the tab group'
    it 'returns 1 if not a group'
  end
  
  describe '#activate_tab_with_click' do
    it 'returns windowid of window activated'
    context 'when the window is already active' do
      it 'returns 0'
    end
    context 'when the tab button is not visible' do
      it 'raises exception'
    end
  end
end