# encoding: utf-8
require File.expand_path("../spec_helper", __FILE__)

describe "Del" do

  before :each do
    browser.goto(WatirSpec.files + "/non_control_elements.html")
  end

  # Exists method
  describe "#exist?" do
    it "returns true if the element exists" do
      browser.del(:id, "lead").exists?.should be_true
    end

    it "returns false if the element doesn't exist" do
      browser.del(:id, "no_such_id").should_not exist
    end
  end

  describe "how" do
    it "can be :id" do
      browser.del(:id, "lead").exists?.should be_true
    end

    it "can be :text" do
      browser.del(:text, "This is a deleted text tag 1").exists?.should be_true
    end

    it "can be :lead" do
      browser.del(:class, "lead").exists?.should be_true
    end

    it "can be :index" do
      browser.del(:index, 1).exists?.should be_true
    end

    it "can be :xpath" do
      browser.del(:xpath, "//del[@id='lead']").exists?.should be_true
    end

    it "defaults to :id)" do
      browser.del("lead").exists?.should be_true
    end

    it "returns the first del if not given" do
      browser.del.exists?.should be_true
    end

    it "raises TypeError when 'what' argument is invalid" do
      lambda { browser.del(:id, 3.14).exists? }.should raise_error(TypeError)
    end

    it "raises MissingWayOfFindingObjectException when 'how' argument is invalid" do
      lambda { browser.del(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
    end
  end

  # Attribute methods
  describe "#class_name" do
    it "returns the class attribute" do
      browser.del(:index, 1).class_name.should == 'lead'
    end

    it "returns an empty string if the element exists and the attribute doesn't" do
      browser.del(:index, 3).class_name.should == ''
    end

    it "raises UnknownObjectException if the del doesn't exist" do
      lambda { browser.del(:id, 'no_such_id').class_name }.should raise_error(UnknownObjectException)
    end
  end

  describe "#id" do
    it "returns the id attribute" do
      browser.del(:index, 1).id.should == "lead"
    end

    it "returns an empty string if the element exists and the attribute doesn't" do
      browser.del(:index, 3).id.should == ''
    end

    it "raises UnknownObjectException if the del doesn't exist" do
      lambda { browser.del(:id, "no_such_id").id }.should raise_error(UnknownObjectException)
      lambda { browser.del(:index, 1337).id }.should raise_error(UnknownObjectException)
    end
  end

  describe "#name" do
    it "returns the name attribute" do
      browser.del(:index, 2).name.should == "invalid_attribute"
    end

    it "returns an empty string if the element exists and the attribute doesn't" do
      browser.del(:index, 3).name.should == ''
    end

    it "raises UnknownObjectException if the del doesn't exist" do
      lambda { browser.del(:id, "no_such_id").name }.should raise_error(UnknownObjectException)
    end
  end

  describe "#title" do
    it "returns the title attribute" do
      browser.del(:index, 1).title.should == 'Lorem ipsum'
    end

    it "returns an empty string if the element exists and the attribute doesn't" do
      browser.del(:index, 3).title.should == ''
    end

    it "raises UnknownObjectException if the del doesn't exist" do
      lambda { browser.del(:id, 'no_such_id').title }.should raise_error( UnknownObjectException)
    end
  end

  describe "#text" do
    it "returns the text of the del" do
      browser.del(:index, 2).text.should == 'This is a deleted text tag 2'
    end

    it "returns an empty string if the element doesn't contain any text" do
      browser.del(:index, 4).text.should == ''
    end

    it "raises UnknownObjectException if the del doesn't exist" do
      lambda { browser.del(:id, 'no_such_id').text }.should raise_error( UnknownObjectException)
    end
  end

  describe "#value" do
    it "returns the value attribute" do
      browser.del(:index, 2).value.should == "invalid_attribute"
    end

    it "returns an empty string if the element exists and the attribute doesn't" do
      browser.del(:index, 4).value.should == ''
    end

    it "raises UnknownObjectException if the del doesn't exist" do
      lambda { browser.del(:id , "no_such_id").value }.should raise_error(UnknownObjectException)
    end
  end

  # Other
  describe "#click" do
    it "fires events" do
      browser.del(:name, 'footer').text.should_not include('Javascript')
      browser.del(:name, 'footer').click
      browser.del(:name, 'footer').text.should include('Javascript')
    end

    it "raises UnknownObjectException if the del doesn't exist" do
      lambda { browser.del(:id, "no_such_id").click }.should raise_error(UnknownObjectException)
      lambda { browser.del(:title, "no_such_title").click }.should raise_error(UnknownObjectException)
    end
  end

  describe "#to_s" do
    bug "WTR-350", :watir do
      it "returns a human readable representation of the element" do
        browser.del(:index, 2).to_s.should == "tag:          del\n" +
                                        "  name:         invalid_attribute\n" +
                                        "  value:        invalid_attribute\n" +
                                        "  text:         This is a deleted text tag 2"
      end
    end

    it "raises UnknownObjectException if the p doesn't exist" do
      lambda { browser.del(:xpath, "//del[@id='no_such_id']").to_s }.should raise_error( UnknownObjectException)
    end
  end

end
