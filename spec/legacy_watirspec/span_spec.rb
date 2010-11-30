# encoding: utf-8
require File.expand_path("../spec_helper", __FILE__)

describe "Span" do

  before :each do
    browser.goto(WatirSpec.files + "/non_control_elements.html")
  end

  # Exists method
  describe "#exist?" do
    it "returns true if the 'span' exists" do
      browser.span(:id, "lead").exists?.should be_true
    end
    it "returns false if the element doesn't exist" do
      browser.span(:id, "no_such_id").should_not exist
    end
  end

  describe "how" do
    it "can be :id" do
      browser.span(:id, "lead").exists?.should be_true
    end

    it "can be :text" do
      browser.span(:text, "Dubito, ergo cogito, ergo sum.").exists?.should be_true
    end

    it "can be :class" do
      browser.span(:class, "lead").exists?.should be_true
    end

    it "can be :index" do
      browser.span(:index, 1).exists?.should be_true
    end

    it "defaults to :id" do
      browser.span("lead").exists?.should be_true
    end

    it "returns the first span if given no args" do
      browser.span.exists?.should be_true
    end

    it "raises TypeError when 'what' argument is invalid" do
      lambda { browser.span(:id, 3.14).exists? }.should raise_error(TypeError)
    end

    it "raises MissingWayOfFindingObjectException when 'how' argument is invalid" do
      lambda { browser.span(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
    end
  end

  # Attribute methods
  describe "#class_name" do
    it "returns the class attribute" do
      browser.span(:index, 1).class_name.should == 'lead'
    end

    it "returns an empty string if the element exists and the attribute doesn't" do
      browser.span(:index, 3).class_name.should == ''
    end

    it "raises UnknownObjectException if the span doesn't exist" do
      lambda { browser.span(:id, 'no_such_id').class_name }.should raise_error(UnknownObjectException)
    end
  end

  describe "#id" do
    it "returns the id attribute" do
      browser.span(:index, 1).id.should == "lead"
    end

    it "returns an empty string if the element exists and the attribute doesn't" do
      browser.span(:index, 3).id.should == ''
    end

    it "raises UnknownObjectException if the span doesn't exist" do
      lambda { browser.span(:id, "no_such_id").id }.should raise_error(UnknownObjectException)
    end
  end

  describe "#name" do
    it "returns the name attribute" do
      browser.span(:index, 2).name.should == "invalid_attribute"
    end

    it "returns an empty string if the element exists and the attribute doesn't" do
      browser.span(:index, 3).name.should == ''
    end

    it "raises UnknownObjectException if the span doesn't exist" do
      lambda { browser.span(:id, "no_such_id").name }.should raise_error(UnknownObjectException)
    end
  end

  describe "#title" do
    it "returns the title attribute" do
      browser.span(:index, 1).title.should == 'Lorem ipsum'
    end

    it "returns an empty string if the element exists and the attribute doesn't" do
      browser.span(:index, 3).title.should == ''
    end

    it "raises UnknownObjectException if the span doesn't exist" do
      lambda { browser.span(:id, 'no_such_id').title }.should raise_error( UnknownObjectException)
    end
  end

  describe "#text" do
    it "returns the text of the span" do
      browser.span(:index, 2).text.should == 'Sed pretium metus et quam. Nullam odio dolor, vestibulum non, tempor ut, vehicula sed, sapien. Vestibulum placerat ligula at quam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.'
    end

    it "returns an empty string if the element doesn't contain any text" do
      browser.span(:index, 5).text.should == ''
    end

    it "raises UnknownObjectException if the span doesn't exist" do
      lambda { browser.span(:id, 'no_such_id').text }.should raise_error( UnknownObjectException)
    end
  end

  describe "#value" do
    it "returns the value attribute" do
      browser.span(:index, 2).value.should == "invalid_attribute"
    end

    it "returns an empty string if the element exists and the attribute doesn't" do
      browser.span(:index, 3).value.should == ''
    end

    it "raises UnknownObjectException if the span doesn't exist" do
      lambda { browser.span(:id , "no_such_id").value }.should raise_error(UnknownObjectException)
      lambda { browser.span(:index , 1337).value }.should raise_error(UnknownObjectException)
    end
  end

  # Other
  describe "#click" do
    it "fires events" do
      browser.span(:name, 'footer').text.should_not include('Javascript')
      browser.span(:name, 'footer').click
      browser.span(:name, 'footer').text.should include('Javascript')
    end

    it "raises UnknownObjectException if the span doesn't exist" do
      lambda { browser.span(:id, "no_such_id").click }.should raise_error(UnknownObjectException)
    end
  end

  describe "#to_s" do
    bug "WTR-350", :watir do
      it "returns a human readable representation of the element" do
        browser.span(:index, 2).to_s.should == "tag:          span\n" +
                                        "  name:         invalid_attribute\n" +
                                        "  value:        invalid_attribute\n" +
                                        "  text:         Sed pretium metus et quam. Nullam odio dolor, vestibulum non, tempor ut, vehicula sed, sapien. Vestibulum placerat ligula at quam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas."
      end
    end

    it "raises UnknownObjectException if the p doesn't exist" do
      lambda { browser.span(:xpath, "//span[@id='no_such_id']").to_s }.should raise_error( UnknownObjectException)
    end
  end

end
