# encoding: utf-8
require File.expand_path("../spec_helper", __FILE__)

describe "Em" do

  before :each do
    browser.goto(WatirSpec.files + "/non_control_elements.html")
  end

  # Exists method
  describe "#exists?" do
    it "returns true if the element exists" do
      browser.em(:id, "important-id").exists?.should be_true
    end

    it "returns false if the element does not exist" do
      browser.em(:id, "no_such_id").should_not exist
    end
  end

  describe "how" do
    it "can be :id" do
      browser.em(:id, "important-id").exists?.should be_true
    end

    it "can be :class" do
      browser.em(:class, "important-class").exists?.should be_true
    end

    it "can be :xpath" do
      browser.em(:xpath, "//em[@id='important-id']").exists?.should be_true
    end

    it "can be :index" do
      browser.em(:index, 1).exists?.should be_true
    end

    it "returns the first em if given no args" do
      browser.em.exists?.should be_true
    end

    it "raises TypeError when 'what' argument is invalid" do
      lambda { browser.em(:id, 3.14).exists? }.should raise_error(TypeError)
    end

    it "raises MissingWayOfFindingObjectException when 'how' argument is invalid" do
      lambda { browser.em(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
    end
  end

  # Attribute methods
  describe "#class_name" do
    it "returns the class attribute if the element exists" do
      browser.em(:id, "important-id").class_name.should == "important-class"
    end

    it "raises UnknownObjectException if the element does not exist" do
      lambda { browser.em(:id, "no_such_id").class_name }.should raise_error(UnknownObjectException)
    end
  end

  describe "#id" do
    it "returns the id attribute if the element exists" do
      browser.em(:class, 'important-class').id.should == "important-id"
    end

    it "raises UnknownObjectException if the element does not exist" do
      lambda {browser.em(:id, "no_such_id").id }.should raise_error(UnknownObjectException)
    end
  end

  describe "#title" do
    it "returns the title of the element" do
      browser.em(:class, "important-class").title.should == "ergo cogito"
    end
  end

  describe "#text" do
    it "returns the text of the element" do
      browser.em(:id, "important-id").text.should == "ergo cogito"
    end

    it "raises UnknownObjectException if the element does not exist" do
      lambda { browser.em(:id, "no_such_id").text }.should raise_error(UnknownObjectException)
    end
  end

  # Manipulation methods
  describe "#click" do
    it "raises UnknownObjectException if the element does not exist" do
      lambda { browser.em(:id, "no_such_id").click }.should raise_error(UnknownObjectException)
    end
  end

  describe "#to_s" do
    bug "WTR-350", :watir do
      it "returns a human readable representation of the element" do
        browser.em(:id, 'important-id').to_s.should ==
%q{tag:          em
  class:        important-class
  id:           important-id
  title:        ergo cogito
  text:         ergo cogito}
      end
    end
  end

end
