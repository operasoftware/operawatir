# encoding: utf-8
require File.expand_path("../spec_helper", __FILE__)

describe "Li" do

  before :each do
    browser.goto(WatirSpec.files + "/non_control_elements.html")
  end

  # Exists method
  describe "#exist?" do
    it "returns true if the 'li' exists" do
      browser.li(:id, "non_link_1").exists?.should be_true
    end

    it "returns false if the 'li' doesn't exist" do
      browser.li(:id, "no_such_id").should_not exist
    end
  end

  describe "how" do
    it "can be :id" do
      browser.li(:id, "non_link_1").exists?.should be_true
    end

    it "can be :text" do
      browser.li(:text, "Non-link 3").exists?.should be_true
    end

    it "can be :class" do
      browser.li(:class, "nonlink").exists?.should be_true
    end

    it "can be :index" do
      browser.li(:index, 1).exists?.should be_true
    end

    it "can be :xpath" do
      browser.li(:xpath, "//li[@id='non_link_1']").exists?.should be_true
    end

    it "defaults to :id" do
      browser.li("non_link_1").exists?.should be_true
    end

    it "returns the first element if given no args" do
      browser.li.exists?.should be_true
    end


    it "raises TypeError when 'what' argument is invalid" do
      lambda { browser.li(:id, 3.14).exists? }.should raise_error(TypeError)
    end

    it "raises MissingWayOfFindingObjectException when 'how' argument is invalid" do
      lambda { browser.li(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
    end
  end

  # Attribute methods
  describe "#class_name" do
    it "returns the class attribute" do
      browser.li(:id, 'non_link_1').class_name.should == 'nonlink'
    end

    it "returns an empty string if the element exists and the attribute doesn't" do
      browser.li(:index, 1).class_name.should == ''
    end

    it "raises UnknownObjectException if the li doesn't exist" do
      lambda { browser.li(:id, 'no_such_id').class_name }.should raise_error(UnknownObjectException)
    end
  end

  describe "#id" do
    it "returns the id attribute" do
      browser.li(:class, 'nonlink').id.should == "non_link_1"
    end

    it "returns an empty string if the element exists and the attribute doesn't" do
      browser.li(:index, 1).id.should == ''
    end

    it "raises UnknownObjectException if the li doesn't exist" do
      lambda { browser.li(:id, "no_such_id").id }.should raise_error(UnknownObjectException)
    end
  end

  describe "#title" do
    it "returns the title attribute" do
      browser.li(:id, 'non_link_1').title.should == 'This is not a link!'
    end

    it "returns an empty string if the element exists and the attribute doesn't" do
      browser.li(:index, 1).title.should == ''
    end

    it "raises UnknownObjectException if the li doesn't exist" do
      lambda { browser.li(:id, 'no_such_id').title }.should raise_error( UnknownObjectException)
    end
  end

  describe "#text" do
    it "returns the text of the p" do
      browser.li(:id, 'non_link_1').text.should == 'Non-link 1'
    end

    it "returns an empty string if the element doesn't contain any text" do
      browser.li(:index, 1).text.should == ''
    end

    it "raises UnknownObjectException if the li doesn't exist" do
      lambda { browser.li(:id, 'no_such_id').text }.should raise_error( UnknownObjectException)
    end
  end

  # Other
  describe "#to_s" do
    it "returns a human readable representation of the element" do
      browser.li(:id, 'non_link_1').to_s.should == "tag:          li\n" +
                                      "  id:           non_link_1\n" +
                                      "  class:        nonlink\n" +
                                      "  title:        This is not a link!\n" +
                                      "  text:         Non-link 1"
    end

    it "raises UnknownObjectException if the li doesn't exist" do
      lambda { browser.li(:xpath, "//li[@id='no_such_id']").to_s }.should raise_error( UnknownObjectException)
    end
  end

end
