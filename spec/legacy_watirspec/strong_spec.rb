# encoding: utf-8
require File.expand_path("../spec_helper", __FILE__)

describe "Strong" do

  before :each do
    browser.goto(WatirSpec.files + "/non_control_elements.html")
  end

  # Exists method
  describe "#exist?" do
    it "returns true if the element exists" do

    end

    it "returns false if the element doesn't exist" do
      browser.strong(:id, "no_such_id").should_not exist
    end
  end

  describe "how" do
    it "can be :id" do
      browser.strong(:id, "descartes").exists?.should be_true
    end

    it "can be :text" do
      browser.strong(:text, "Dubito, ergo cogito, ergo sum.").exists?.should be_true
    end

    it "can be :class" do
      browser.strong(:class, "descartes").exists?.should be_true
    end

    it "can be :index" do
      browser.strong(:index, 1).exists?.should be_true
    end

    it "defaults to :id)" do
      browser.strong("descartes").exists?.should be_true
    end

    it "returns the first strong if given no args" do
      browser.strong.exists?.should be_true
    end

    it "raises TypeError when 'what' argument is invalid" do
      lambda { browser.strong(:id, 3.14).exists? }.should raise_error(TypeError)
    end

    it "raises MissingWayOfFindingObjectException when 'how' argument is invalid" do
      lambda { browser.strong(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
    end
  end

  # Attribute methods
  describe "#class_name" do
    it "returns the class attribute" do
      browser.strong(:index, 1).class_name.should == 'descartes'
    end

    it "returns an empty string if the element exists and the attribute doesn't" do
      browser.strong(:index, 2).class_name.should == ''
    end

    it "raises UnknownObjectException if the element doesn't exist" do
      lambda { browser.strong(:id, 'no_such_id').class_name }.should raise_error(UnknownObjectException)
    end
  end

  describe "#id" do
    it "returns the id attribute" do
      browser.strong(:index, 1).id.should == "descartes"
    end

    it "raises UnknownObjectException if the element doesn't exist" do
      lambda { browser.strong(:id, "no_such_id").id }.should raise_error(UnknownObjectException)
    end
  end

  describe "#text" do
    it "returns the text of the element" do
      browser.strong(:index, 1).text.should == "Dubito, ergo cogito, ergo sum."
    end

    it "raises UnknownObjectException if the element doesn't exist" do
      lambda { browser.strong(:id, 'no_such_id').text }.should raise_error( UnknownObjectException)
    end
  end
  # Other
end
