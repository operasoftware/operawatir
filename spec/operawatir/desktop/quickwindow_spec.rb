# encoding: utf-8
require File.expand_path('../watirspec_helper', __FILE__)

describe 'quick_window' do

  describe "#exist?" do
    it "returns true for existing window"
    it "returns false for non-existing window"
  end

  describe "#type" do
    it "returns Normal for Document Window"
    it "returns Dialog for Dialog"
  end

  describe "#name" do
    it "is non-empty"
  end
    
  describe "#title" do
    is "non-empty"
  end
        
  describe "#to_s" do
   
  end
    
  describe "#on_screen?" do
  end
    
  describe "#window_id" do
    it "is non-zero integer"
  end
    
  describe "#window_info_string" do
  end

    # @private    
  describe "#driver" do
  end

#private
#    def parent_widget
#    def element(refresh = false)
#    def find
end