require File.expand_path('../../../watirspec_desktophelper', __FILE__)

shared_examples_for 'an editfield' do
  describe '#focus_with_click' do
    it 'focuses editfield' do
      widget.focus_with_click
    end
  end
      
  #describe '#type_text' do
  #end
  #describe '#clear' do
  #end
  #describe '#key_press' do
  #end
end

shared_examples_for 'a widget' do
  describe '#exist?' do
    it 'returns true for existing widget' do
      widget.should exist
    end
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
      
    describe '#enabled?' do
      it 'should return boolean' do
        [true, false].should include widget.enabled?
      end
    end
       
     describe '#visible?' do
       it 'should return boolean' do
        [true, false].should include widget.enabled?
       end
     end
 
end

