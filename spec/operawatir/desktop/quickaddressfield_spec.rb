require File.expand_path('../../watirspec_desktophelper', __FILE__)
require File.expand_path('../shared/shared', __FILE__)

describe 'QuickAddressfield' do
  
   let(:addressfield) { browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field") }
   let(:unknown_addressfield) { browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "no_address_field") }
   let(:widget) { browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field") }
  
   subject { addressfield }
     
   it_behaves_like 'a widget'
   it_behaves_like 'an editfield'
   
   describe '#quick_addressfield' do
     it 'constructs addressfield by its name' do
       browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field")
     end
     it 'constructs addressfield by its name' do
            browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field2")
     end
   end
   
   its(:type) { should == :addressfield }
 
   describe '#load_page_with_url' do
     it 'loads page' do
       addressfield.load_page_with_url("opera:debug").should == "opera:debug"
     end
     it 'throws exception if unknown addressfield' do
       expect { unknown_addressfield.highlighted_text }.to raise_error OperaWatir::Exceptions::UnknownObjectException
     end
   end

    describe '#text' do
      its(:text) { should == "opera:debug" }
        
      it 'throws exception if unknown addressfield' do
       expect { unknown_addressfield.highlighted_text }.to raise_error OperaWatir::Exceptions::UnknownObjectException
      end
    end
    
    describe '#visible_text' do
      its(:visible_text) { should == "debug" }
    
      it 'throws exception if unknown addressfield' do
       expect { unknown_addressfield.highlighted_text }.to raise_error OperaWatir::Exceptions::UnknownObjectException
      end
   end
   
   describe '#highlighted_text' do
     its(:highlighted_text) { should == "" }
     
     it 'throws exception if unknown addressfield' do
       expect { unknown_addressfield.highlighted_text }.to raise_error OperaWatir::Exceptions::UnknownObjectException
     end
    end

end