require File.expand_path('../../watirspec_helper', __FILE__)

describe "QuickAddressfield" do
  
   let(:addressfield) { browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field") }
   let(:unknown_addressfield) { browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "no_address_field") }
  
   describe "#load_page_with_url" do
     it "loads page" do
       addressfield.load_page_with_url("opera:debug").should == "opera:debug"
     end
     it "throws exception if unknown addressfield" do
       expect { unknown_addressfield.highlighted_text }.to raise_error OperaWatir::Exceptions::UnknownObjectException
     end
   end

   describe "text" do
     before(:each) do
       addressfield.load_page_with_url("opera:debug").should == "opera:debug"
    end
    describe "#visible_text" do
     it "returns the visible text" do
       addressfield.visible_text.should == "debug"
     end
     it "throws exception if unknown addressfield" do
       expect { unknown_addressfield.highlighted_text }.to raise_error OperaWatir::Exceptions::UnknownObjectException
     end
   end
   
   describe "#highlighted_text" do
     it "returns the highlighted text" do
       addressfield.highlighted_text.should == ""
     end
     it "throws exception if unknown addressfield" do
       expect { unknown_addressfield.highlighted_text }.to raise_error OperaWatir::Exceptions::UnknownObjectException
     end
    end
   end
end