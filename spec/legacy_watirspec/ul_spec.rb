# encoding: utf-8
require File.expand_path("../spec_helper", __FILE__)

describe "Ul" do

  before :each do
    browser.goto(WatirSpec.files + "/non_control_elements.html")
  end

  # Exists method
  describe "#exist?" do
    it "returns true if the 'ul' exists" do
      browser.ul(:id, "navbar").should exist
    end

    it "returns false if the 'ul' doesn't exist" do
      browser.ul(:id, "no_such_id").should_not exist
    end
  end

  describe "how" do
    it "can be :id" do
      browser.ul(:id, "navbar").should exist
    end

    it "can be :index" do
      browser.ul(:index, 1).should exist
    end

    it "can be :xpath" do
      browser.ul(:xpath, "//ul[@id='navbar']").should exist
    end

    it "defaults to :id" do
      browser.ul("navbar").should exist
    end

    it "returns the first ul if given no args" do
      browser.ul.should exist
    end

    it "raises TypeError when 'what' argument is invalid" do
      lambda { browser.ul(:id, 3.14).exists? }.should raise_error(TypeError)
    end

    it "raises MissingWayOfFindingObjectException when 'how' argument is invalid" do
      lambda { browser.ul(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
    end
  end

  # Attribute methods
  describe "#class_name" do
    it "returns the class attribute" do
      browser.ul(:id, 'navbar').class_name.should == 'navigation'
    end

    it "returns an empty string if the element exists and the attribute doesn't" do
      browser.ul(:index, 2).class_name.should == ''
    end

    it "raises UnknownObjectException if the ul doesn't exist" do
      lambda { browser.ul(:id, 'no_such_id').class_name }.should raise_error(UnknownObjectException)
    end
  end

  describe "#id" do
    it "returns the id attribute" do
      browser.ul(:class, 'navigation').id.should == "navbar"
    end

    it "returns an empty string if the element exists and the attribute doesn't" do
      browser.ul(:index, 2).id.should == ''
    end

    it "raises UnknownObjectException if the ul doesn't exist" do
      lambda { browser.ul(:id, "no_such_id").id }.should raise_error(UnknownObjectException)
    end
  end

end
