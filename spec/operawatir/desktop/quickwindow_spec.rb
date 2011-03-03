# encoding: utf-8
require File.expand_path('../../watirspec_helper', __FILE__)

describe 'QuickWindow' do
  let(:documentwindow) { browser.quick_window(:name, "Document Window") }
  let(:browserwindow) { browser.quick_window(:name, "Browser Window") }
  let(:nonexisting_window) { browser.quick_window(:name, "Doc Window") }
  
  describe "#exist?" do
    it "returns true for existing window" do
      browserwindow.should exist
    end
    
    it "returns false for non-existing window" do
      nonexisting_window.should_not exist
    end
  end

  describe "#type" do
    it "returns Normal for Document Window" do
      documentwindow.type == "Normal"
    end
    
    it "returns Dialog for Dialog" do
      browser.open_dialog_with_key_press("New Preferences Dialog", "F12", :ctrl).should > 0
      browser.quick_window(:name, "New Preferences Dialog").type == "Dialog"
      browser.close_dialog("New Preferences Dialog")
    end
    
    it "throws exception if unknown window" do
      expect { nonexisting_window.type }.to raise_error OperaWatir::Exceptions::UnknownObjectException
    end
  end

  describe "#name" do
    it "returns window name" do
      documentwindow.name.should_not be_empty
    end
    it "returns a string" do
      documentwindow.name.should be_kind_of String
    end
    it "throws exception if unknown window" do
      expect { nonexisting_window.name }.to raise_error OperaWatir::Exceptions::UnknownObjectException
    end
  end
    
  describe "#title" do
    it "returns title" do
      documentwindow.title.should_not be_empty
    end
    it "returns a string" do
      documentwindow.title.should be_kind_of String
    end
    it "throws exception if unknown window" do
      expect { nonexisting_window.title }.to raise_error OperaWatir::Exceptions::UnknownObjectException
    end

  end
        
  describe "#to_s" do
    it "returns string" do
      documentwindow.to_s.should_not be_empty
    end
    it "returns a string" do
      documentwindow.to_s.should be_kind_of String
    end
    it "throws exception if unknown window" do
      expect { nonexisting_window.to_s }.to raise_error OperaWatir::Exceptions::UnknownObjectException
    end

  end
    
  describe "#on_screen?" do
    it "throws exception if unknown window" do
      expect { nonexisting_window.on_screen? }.to raise_error OperaWatir::Exceptions::UnknownObjectException
    end
  end
    
  describe "#window_id" do
    it "is non-zero integer" do
      documentwindow.window_id.should_not be_zero
    end
    it "returns an integer" do
      documentwindow.window_id.should be_integer
    end
    it "throws exception if unknown window" do
      expect { nonexisting_window.window_id }.to raise_error OperaWatir::Exceptions::UnknownObjectException
    end
  end
    
  describe "#window_info_string" do
    it "returns string" do
        documentwindow.window_info_string.should be_kind_of String
    end
    it "is nonempty" do
        documentwindow.window_info_string.should_not be_empty
    end
    it "throws exception if unknown window" do
      expect { nonexisting_window.window_info_string }.to raise_error OperaWatir::Exceptions::UnknownObjectException
    end
  end

    # @private    
  describe "#driver" do
  end

#private
#    def parent_widget
#    def element(refresh = false)
#    def find
end