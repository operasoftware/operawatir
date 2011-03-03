# encoding: utf-8
require File.expand_path('../../watirspec_helper', __FILE__)

describe 'quick_window' do

  describe "#exist?" do
    it "returns true for existing window" do
      browser.quick_window(:name, "Browser Window").should exist
    end
    
    it "returns false for non-existing window" do
      browser.quick_window(:name, "Nonexisting window").should_not exist
    end
  end

  describe "#type" do
    it "returns Normal for Document Window" do
      browser.quick_window(:name, "Document Window").type == "Normal"
    end
    
    it "returns Dialog for Dialog" do
      browser.open_dialog_with_key_press("New Preferences Dialog", "F12", :ctrl).should > 0
      browser.quick_window(:name, "New Preferences Dialog").type == "Dialog"
      browser.close_dialog("New Preferences Dialog")
    end
    
    it "throws exception if unknown window" do
      expect { browser.quick_window(:name, "Doc Window").type }.to raise_error OperaWatir::Exceptions::UnknownObjectException
    end
  end

  describe "#name" do
    it "returns window name" do
      browser.quick_window(:name, "Document Window").name.should_not be_empty
    end
    it "returns a string" do
      browser.quick_window(:name, "Document Window").name.should be_kind_of String
    end
    it "throws exception if unknown window" do
      expect { browser.quick_window(:name, "Doc Window").name }.to raise_error OperaWatir::Exceptions::UnknownObjectException
    end
  end
    
  describe "#title" do
    it "returns title" do
      browser.quick_window(:name, "Document Window").title.should_not be_empty
    end
    it "returns a string" do
      browser.quick_window(:name, "Document Window").title.should be_kind_of String
    end
    it "throws exception if unknown window" do
      expect { browser.quick_window(:name, "Doc Window").title }.to raise_error OperaWatir::Exceptions::UnknownObjectException
    end

  end
        
  describe "#to_s" do
    it "returns string" do
      browser.quick_window(:name, "Document Window").to_s.should_not be_empty
    end
    it "returns a string" do
      browser.quick_window(:name, "Document Window").to_s.should be_kind_of String
    end
    it "throws exception if unknown window" do
      expect { browser.quick_window(:name, "Doc Window").to_s }.to raise_error OperaWatir::Exceptions::UnknownObjectException
    end

  end
    
  describe "#on_screen?" do
    it "throws exception if unknown window" do
      expect { browser.quick_window(:name, "Doc Window").on_screen? }.to raise_error OperaWatir::Exceptions::UnknownObjectException
    end
  end
    
  describe "#window_id" do
    it "is non-zero integer" do
      browser.quick_window(:name, "Document Window").window_id.should_not be_zero
    end
    it "returns an integer" do
      browser.quick_window(:name, "Document Window").window_id.should be_integer
    end
    it "throws exception if unknown window" do
      expect { browser.quick_window(:name, "Doc Window").window_id }.to raise_error OperaWatir::Exceptions::UnknownObjectException
    end
  end
    
  describe "#window_info_string" do
    it "returns string" do
        browser.quick_window(:name, "Document Window").window_info_string.should be_kind_of String
    end
    it "is nonempty" do
        browser.quick_window(:name, "Document Window").window_info_string.should_not be_empty
    end
    it "throws exception if unknown window" do
      expect { browser.quick_window(:name, "Doc Window").window_info_string }.to raise_error OperaWatir::Exceptions::UnknownObjectException
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