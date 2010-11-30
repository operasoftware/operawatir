# encoding: utf-8
require File.expand_path("../spec_helper", __FILE__)

describe "Hidden" do

  before :each do
    browser.goto(WatirSpec.files + "/forms_with_input_elements.html")
  end

  # Exist method
  describe "#exists?" do
    it "returns true if the element exists" do
      browser.hidden(:id, 'new_user_interests_dolls').exists?.should be_true
    end
    it "returns false if the element does not exist" do
      browser.hidden(:id, 'no_such_id').should_not exist
    end
  end

  describe "how" do
    it "can be :id" do
      browser.hidden(:id, 'new_user_interests_dolls').exists?.should be_true
    end

    it "can be :name" do
      browser.hidden(:name, 'new_user_interests').exists?.should be_true
    end

    it "can be :value" do
      browser.hidden(:value, 'dolls').exists?.should be_true
    end

    it "can be :class" do
      browser.hidden(:class, 'fun').exists?.should be_true
    end

    it "can be :index" do
      browser.hidden(:index, 1).exists?.should be_true
    end

    it "can be :xpath" do
      browser.hidden(:xpath, "//input[@id='new_user_interests_dolls']").exists?.should be_true
    end

    it "returns the first hidden if not given" do
      browser.hidden.exists?.should be_true
    end

    it "defaults to :name)" do
      browser.hidden("new_user_interests").exists?.should be_true
    end

    it "raises TypeError when 'what' argument is invalid" do
      lambda { browser.hidden(:id, 3.14).exists? }.should raise_error(TypeError)
    end

    it "raises MissingWayOfFindingObjectException when 'how' argument is invalid" do
      lambda { browser.hidden(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
    end
  end

  # Attribute methods
  describe "#id" do
    it "returns the id attribute if the text field exists" do
      browser.hidden(:index, 1).id.should == "new_user_interests_dolls"
    end

    it "raises UnknownObjectException if the text field doesn't exist" do
      lambda { browser.hidden(:index, 1337).id }.should raise_error(UnknownObjectException)
    end
  end

  describe "#name" do
    it "returns the name attribute if the text field exists" do
      browser.hidden(:index, 1).name.should == "new_user_interests"
    end

    it "raises UnknownObjectException if the text field doesn't exist" do
      lambda { browser.hidden(:index, 1337).name }.should raise_error(UnknownObjectException)
    end
  end

  describe "#type" do
    it "returns the type attribute if the text field exists" do
      browser.hidden(:index, 1).type.should == "hidden"
    end

    it "raises UnknownObjectException if the text field doesn't exist" do
      lambda { browser.hidden(:index, 1337).type }.should raise_error(UnknownObjectException)
    end
  end

  describe "#value" do
    it "returns the value attribute if the text field exists" do
      browser.hidden(:index, 1).value.should == "dolls"
    end

    it "raises UnknownObjectException if the text field doesn't exist" do
      lambda { browser.hidden(:index, 1337).value }.should raise_error(UnknownObjectException)
    end
  end

  # Manipulation methods
  describe "#value=" do
    it "sets the value of the element" do
      browser.hidden(:id, 'new_user_interests_dolls').value = 'guns'
      browser.hidden(:id, "new_user_interests_dolls").value.should == 'guns'
    end

    it "raises UnknownObjectException if the text field doesn't exist" do
      lambda { browser.hidden(:id, 'no_such_id').value = 'guns' }.should raise_error(UnknownObjectException)
    end
  end


end
