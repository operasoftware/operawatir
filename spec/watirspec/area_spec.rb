# encoding: utf-8
require File.expand_path("../spec_helper", __FILE__)

describe "Area" do

  before :each do
    @window = browser.goto(fixture('images.html'))
  end

  # Exists method
  describe "#exist?" do

    it "returns true if the area exists" do
      @window.area(:id => "NCE").should exist
      @window.area(:id => /NCE/).should exist
      @window.area(:title => "Tables").should exist
      @window.area(:title => /Tables/).should exist

      @window.area(:href => "tables.html").should exist
      @window.area(:href => /tables/).should exist

      @window.area.should exist
      # @window.area(:xpath => "//area[@id='NCE']").should exist
    end

    it "returns the first area if given no args" do
      @window.area.should exist
    end

    it "returns false if the area doesn't exist" do
      @window.area(:id => "no_such_id").should_not exist
      @window.area(:id => /no_such_id/).should_not exist
      @window.area(:title => "no_such_title").should_not exist
      @window.area(:title => /no_such_title/).should_not exist

      @window.area(:href => "no-tables.html").should_not exist
      @window.area(:href => /no-tables/).should_not exist

      @window.area[1337].should_not exist
      
      # TODO Bogus test
      # If you are trying to find an xpath, you can't provide an XPath.
      
      # @window.area(:xpath => "//area[@id='no_such_id']").should_not exist
    end

    # TODO Bogus test
    # 3.14 should respond to #to_s

    # it "raises TypeError when 'what' argument is invalid" do
    #   lambda { @window.area(:id, 3.14).exists? }.should raise_error(TypeError)
    # end
    
    # TODO Bogus test
    # :no_such_how could be an attribute in HTML5.
    
    # it "raises MissingWayOfFindingObjectException when 'how' argument is invalid" do
    #   lambda { @window.area(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
    # end
  end

  # Attribute methods
  describe "#id" do
    it "returns the id attribute" do
      @window.area[0].id.should == "NCE"
    end

    it "returns an empty string if the element exists and the attribute doesn't" do
      @window.area[2].id.should == ''
    end
    
    it "raises UnknownObjectException if the area doesn't exist" do
      lambda { @window.area(:id => "no_such_id").id }.should raise_error(UnknownObjectException)
      lambda { @window.areas[1337].id }.should raise_error(UnknownObjectException)
    end

  end

  describe "#respond_to?" do
    it "returns true for all attribute methods" do
      @window.area.should respond_to(:id)
    end
  end

end
