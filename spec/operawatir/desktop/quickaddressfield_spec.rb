require File.expand_path('../../watirspec_helper', __FILE__)

#TODO: These should be in quickwidget_spec
shared_examples_for "a widget" do
  describe "#exist?" do
    it "returns true for existing widget" do
      widget.should exist
    end
    its(:text) { should be_kind_of String } #be_a
    its(:name) { should be_kind_of String }
    its(:row_info_string) { should be_kind_of String }
    its(:widget_info_string) { should be_kind_of String }
    its(:parent_name) { should be_kind_of String } # nil?
    its(:value) { should be_integer }
    its(:to_s) { should be_kind_of String }
    its(:driver) { should be_instance_of Java::ComOperaCoreSystems::OperaDesktopDriver }
    #its(:type) { should }
      
    describe "#enabled?" do
      it "should return boolean" do
        [true, false].should include widget.enabled?
      end
    end
       
     describe "#visible?" do
       it "should return boolean" do
        [true, false].should include widget.enabled?
       end
     end
 
  end
end


describe "QuickAddressfield" do
  
   let(:addressfield) { browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field") }
   let(:unknown_addressfield) { browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "no_address_field") }
   let(:widget) { browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field") }
  
   subject { addressfield }
     
   it_behaves_like "a widget"

   describe "#load_page_with_url" do
     it "loads page" do
       addressfield.load_page_with_url("opera:debug").should == "opera:debug"
     end
     it "throws exception if unknown addressfield" do
       expect { unknown_addressfield.highlighted_text }.to raise_error OperaWatir::Exceptions::UnknownObjectException
     end
   end

    describe "#text" do
      its(:text) { should == "opera:debug" }
        
      it "throws exception if unknown addressfield" do
       expect { unknown_addressfield.highlighted_text }.to raise_error OperaWatir::Exceptions::UnknownObjectException
      end
    end
    
    describe "#visible_text" do
      its(:visible_text) { should == "debug" }
    
      it "throws exception if unknown addressfield" do
       expect { unknown_addressfield.highlighted_text }.to raise_error OperaWatir::Exceptions::UnknownObjectException
      end
   end
   
   describe "#highlighted_text" do
     its(:highlighted_text) { should == "" }
     
     it "throws exception if unknown addressfield" do
       expect { unknown_addressfield.highlighted_text }.to raise_error OperaWatir::Exceptions::UnknownObjectException
     end
    end

end