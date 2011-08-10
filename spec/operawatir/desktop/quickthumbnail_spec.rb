require File.expand_path('../../watirspec_desktophelper', __FILE__)
require File.expand_path('../shared/shared', __FILE__)

describe 'QuickThumbnail' do
  
  before(:all) do
    browser.open_window_with_key_press("Document Window", "t", :ctrl)
  end
  
  let(:widget) { browser.quick_thumbnail(:name, "Speed Dial 1") }
  
  subject { widget }
     
  it_behaves_like 'a widget'
  it_behaves_like 'a button'
  
  its(:type) { should == :thumbnail }
   
  #This is really on browser, widgets, and window
  describe '#quick_thumbnail' do
    it 'constructs thumbnail by its position' do
      browser.quick_thumbnail(:pos, 1).should exist
    end
    it 'constructs thumbnail by its name' do
      browser.quick_thumbnail(:name, "Speed Dial 1").should exist
    end
    it 'constructs thumbnail by its text' do #it won't be language independant and will depend on existed Speed Dials
    browser.quick_thumbnail(:text, "Opera Portal").should exist
  end
  end
  
  describe '#move_with_drag' do
    
    it 'moves thumbnail' #do #DSK-335945 bloacks this section
  #  SD1 = browser.quick_window(:name, "Document Window").quick_thumbnail(:name, "Speed Dial 1").text
  #  SD2 = browser.quick_window(:name, "Document Window").quick_thumbnail(:name, "Speed Dial 2").text
  #  thumbnail_to_drop_on = browser.quick_window(:name, "Document Window").quick_thumbnail(:name, "Speed Dial 2")
  #  browser.browser.quick_window(:name, "Document Window").quick_thumbnail(:name, "Speed Dial 1").move_with_drag(thumbnail_to_drop_on)
  #  browser.quick_window(:name, "Document Window").quick_thumbnail(:name, "Speed Dial 1").text.should == SD2
  #  browser.quick_window(:name, "Document Window").quick_thumbnail(:name, "Speed Dial 2").text.should == SD1
  #end
  
    context 'when target is not a thumbnail' do
      it 'raises UnknownObjectException' do
    expect { browser.quick_window(:name, "Document Window").quick_thumbnail(:name, "Speed Dial 1").move_with_drag(browser.quick_window(:name, "Browser Window")) }.to raise_error OperaWatir::DesktopExceptions::UnknownObjectException
    end
    end
  end
   
end

