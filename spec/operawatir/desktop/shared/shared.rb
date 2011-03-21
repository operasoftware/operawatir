require File.expand_path('../../../watirspec_desktophelper', __FILE__)

shared_examples_for 'a button' do
  describe '#default?' do
    it "returns a boolean" do
      [true, false].should include widget.default?
    end
  end
  describe '#value' do
    it "returns 0 or 1" do
      [0, 1].should include widget.value
    end
  end
  describe '#toggle_with_click' do
    it "returns value" do
      [0, 1].should include widget.toggle_with_click
    end
  end
end

shared_examples_for 'an editfield' do
  describe '#focus_with_click' do
    it 'focuses editfield' do
      widget.focus_with_click
    end
  end
      
  describe '#type_text' do
    it "types the given text" do
      widget.type_text "some text"
      widget.focus_with_click # *nix workaround; get rid of addressbar dropdown window
      widget.text.should include "some text"
    end
  end
  
  describe '#clear' do
    it "clears the editfield" do
      widget.clear
      widget.send :element, true #urgh
      widget.text.should be_empty
      
    end
    
    #avoid leaving search dropdown open
    after(:each) do  
      widget.focus_with_click
    end
  end
  
  #describe '#key_press' do
  #end
end

shared_examples_for 'a checkbox' do
  describe '#checked?' do
    it "returns a boolean" do
      [true, false].should include widget.checked?
    end
  end

  describe '#toggle_with_click' do
    it "returns value" do
      [true, false].should include widget.toggle_with_click
    end
  end
end
=begin
shared_examples_for 'a checkbox' do
  describe '#checked?' do
  end

  describe '#toggle_with_click' do
  end

  describe '#open_dialog_with_click' do
  end
end
=end

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
    its(:width) { should be > 0 }
    its(:height) { should be > 0 }
    its(:x) { should be > 0 }
    its(:y) { should be > 0 }
    #its(:type) { should }
      
    describe '#enabled?' do
      it 'returns a boolean' do
        [true, false].should include widget.enabled?
      end
    end
       
     describe '#visible?' do
       it 'returns a boolean' do
        [true, false].should include widget.enabled?
       end
     end
     
  #describe 'print_row' do
  #end

  #describe '#print_widget_info' do
  #end

  
end

