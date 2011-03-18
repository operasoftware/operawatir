# encoding: utf-8
require File.expand_path('../../watirspec_desktophelper', __FILE__)

describe 'QuickWindow' do
  let(:documentwindow) { browser.quick_window(:name, "Document Window") }
  let(:browserwindow) { browser.quick_window(:name, "Browser Window") }
  let(:nonexisting_window) { browser.quick_window(:name, "Doc Window") }
    
  subject { documentwindow }
    
  describe '#quick_window' do
    it "constructs window by id"
    it "constructs window by name"
  end
  
  describe '#exist?' do
    it 'returns true for existing window' do
      browserwindow.should exist
    end
    
    it 'returns false for non-existing window' do
      nonexisting_window.should_not exist
    end
  end

  describe '#type' do
    its(:type) { should == :normal }
      
    it 'returns Dialog for Dialog' do
      browser.open_dialog_with_key_press("New Preferences Dialog", "F12", :ctrl).should > 0
      browser.quick_window(:name, "New Preferences Dialog").type == "Dialog"
      browser.close_dialog("New Preferences Dialog")
    end
    
    it 'throws exception if unknown window' do
      expect { nonexisting_window.type }.to raise_error OperaWatir::Exceptions::UnknownObjectException
    end
  end

  describe '#name' do
    its(:name) { should_not be_empty }
    its(:name) { should be_kind_of String } 
    
    it 'throws exception if unknown window' do
      expect { nonexisting_window.name }.to raise_error OperaWatir::Exceptions::UnknownObjectException
    end
  end
    
  describe '#title' do
    its(:title) { should_not be_empty }
    its(:title) { should be_kind_of String }  
    
    it 'throws exception if unknown window' do
      expect { nonexisting_window.title }.to raise_error OperaWatir::Exceptions::UnknownObjectException
    end

  end
        
  describe '#to_s' do
    it 'returns string' do
      documentwindow.to_s.should_not be_empty
    end
    it 'returns a string' do
      documentwindow.to_s.should be_kind_of String
    end
    it 'throws exception if unknown window' do
      expect { nonexisting_window.to_s }.to raise_error OperaWatir::Exceptions::UnknownObjectException
    end

  end
    
  describe '#on_screen?' do
    it 'throws exception if unknown window' do
      expect { nonexisting_window.on_screen? }.to raise_error OperaWatir::Exceptions::UnknownObjectException
    end
  end
    
  describe '#window_id' do
    its(:window_id) { should be_integer }
    its(:window_id) { should_not be_zero }
    
    it 'throws exception if unknown window' do
      expect { nonexisting_window.window_id }.to raise_error OperaWatir::Exceptions::UnknownObjectException
    end
  end
    
  describe '#window_info_string' do
    its(:window_info_string) { should be_kind_of String }
    its(:window_info_string) { should_not be_empty }
    
    it 'throws exception if unknown window' do
      expect { nonexisting_window.window_info_string }.to raise_error OperaWatir::Exceptions::UnknownObjectException
    end
  end

  its(:driver) { should be_instance_of Java::ComOperaCoreSystems::OperaDesktopDriver }

#private
#    def parent_widget
#    def element(refresh = false)
#    def find
end