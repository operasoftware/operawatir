require File.expand_path('../../watirspec_helper', __FILE__)

describe "quick_addressfield" do
   describe "#load_page_with_url" do
     it "loads page" do
      browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").load_page_with_url("opera:debug").should == "opera:debug"
     end
     it "throws exception if unknown addressfield" do
       expect { browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_fieldd").highlighted_text }.to raise_error OperaWatir::Exceptions::UnknownObjectException
     end
   end

   describe "text" do
     before(:each) do
       browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").load_page_with_url("opera:debug").should == "opera:debug"
    end
   describe "#visible_text" do
     it "returns the visible text" do
       browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").visible_text.should == "debug"
     end
     it "throws exception if unknown addressfield" do
       expect { browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_fieldd").highlighted_text }.to raise_error OperaWatir::Exceptions::UnknownObjectException
     end
   end
   
   describe "#highlighted_text" do
     it "returns the highlighted text" do
       browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").highlighted_text.should == ""
     end
     it "throws exception if unknown addressfield" do
       expect { browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_fieldd").highlighted_text }.to raise_error OperaWatir::Exceptions::UnknownObjectException
     end
    end
   end
end