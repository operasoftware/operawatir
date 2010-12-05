# encoding: utf-8
require File.expand_path("../spec_helper", __FILE__)

describe "Map" do

  before :each do
    browser.goto(WatirSpec.files + "/images.html")
  end

  # Exists method
  describe "#exist?" do
    it "returns true if the 'map' exists" do
      browser.map(:id, "triangle_map").exists?.should be_true
    end
    it "returns false if the 'map' doesn't exist" do
      browser.map(:id, "no_such_id").should_not exist
    end
  end

  describe "how" do
    it "can be :id" do
      browser.map(:id, "triangle_map").exists?.should be_true
    end

    it "can be :name" do
      browser.map(:name, "triangle_map").exists?.should be_true
    end

    it "can be :index" do
      browser.map(:index, 1).exists?.should be_true
    end

    it "can be :xpath" do
      browser.map(:xpath, "//map[@id='triangle_map']").exists?.should be_true
    end

    it "returns true if the element exists (default how = :id)" do
      browser.map("triangle_map").exists?.should be_true
    end

    it "returns the first map if given no args" do
      browser.map.exists?.should be_true
    end

    it "raises TypeError when 'what' argument is invalid" do
      lambda { browser.map(:id, 3.14).exists? }.should raise_error(TypeError)
    end

    it "raises MissingWayOfFindingObjectException when 'how' argument is invalid" do
      lambda { browser.map(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
    end
  end

  # Attribute methods
  describe "#id" do
    it "returns the id attribute" do
      browser.map(:index, 1).id.should == "triangle_map"
    end

    it "returns an empty string if the element exists and the attribute doesn't" do
      browser.map(:index, 2).id.should == ''
    end

    it "raises UnknownObjectException if the p doesn't exist" do
      lambda { browser.map(:id, "no_such_id").id }.should raise_error(UnknownObjectException)
    end
  end

  describe "#name" do
    it "returns the name attribute" do
      browser.map(:index, 1).name.should == "triangle_map"
    end

    it "returns an empty string if the element exists and the attribute doesn't" do
      browser.map(:index, 2).name.should == ''
    end

    it "raises UnknownObjectException if the p doesn't exist" do
      lambda { browser.map(:id, "no_such_id").name }.should raise_error(UnknownObjectException)
    end
  end

  # Other
  describe "#to_s" do
    bug "WTR-350", :watir do
      it "returns a human readable representation of the element" do
        browser.map(:index, 1).to_s.should == "tag:          map\n" +
                                        "  id:           triangle_map\n" +
                                        "  name:         triangle_map"
      end
    end

    it "raises UnknownObjectException if the p doesn't exist" do
      lambda { browser.map(:xpath, "//map[@id='no_such_id']").to_s }.should raise_error( UnknownObjectException)
    end
  end

end
