# encoding: utf-8
require File.expand_path("../spec_helper", __FILE__)

describe "CheckBox" do

  before :each do
    browser.goto(WatirSpec.files + "/forms_with_input_elements.html")
  end

  # Exists method

  describe "#exists?" do
    it "returns false if the checkbox button does not exist" do
      browser.checkbox(:id, "no_such_id").should_not exist
      browser.checkbox(:name, "no_such_name").should_not exist
      browser.checkbox(:value, "no_such_value").should_not exist
      browser.checkbox(:text, "no_such_text").should_not exist
      browser.checkbox(:class, "no_such_class").should_not exist
      browser.checkbox(:index, 1337).should_not exist
      browser.checkbox(:xpath, "//input[@id='no_such_id']").should_not exist
    end
  end

  describe "how" do
    it "can be :id" do
      browser.checkbox(:id, "new_user_interests_books").exists?.should be_true
    end

    it "can be :name" do
      browser.checkbox(:name, "new_user_interests").exists?.should be_true
    end

    it "can be :value" do
      browser.checkbox(:value, "books").exists?.should be_true
    end

    it "can be :class" do
      browser.checkbox(:class, "fun").exists?.should be_true
    end

    it "can be :index" do
      browser.checkbox(:index, 1).exists?.should be_true
    end

    it "can be :xpath" do
      browser.checkbox(:xpath, "//input[@id='new_user_interests_books']").exists?.should be_true
    end

    it "defaults to :name" do
      browser.checkbox("new_user_interests").exists?.should be_true
    end

    it "returns the first checkbox if not given" do
      browser.checkbox.exists?.should be_true
    end

    it "raises TypeError when 'what' argument is invalid" do
      lambda { browser.checkbox(:id, 3.14).exists? }.should raise_error(TypeError)
    end

    it "raises MissingWayOfFindingObjectException when 'how' argument is invalid" do
      lambda { browser.checkbox(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
    end
  end

  describe "value" do
    it "can be passed a value for the checkbox" do
      browser.checkbox(:name, "new_user_interests", 'cars').exists?.should be_true
    end

    it "does not exist if there is no checkbox with the value" do
      browser.checkbox(:name, "new_user_interests", 'no_such_value').should_not exist
    end

    it "does not exist if there is no group with the value" do
      browser.checkbox(:name, "no_such_name", 'cars').should_not exist
    end
  end

  # Attribute methods

  describe "#class_name" do
    it "returns the class name if the checkbox exists and has an attribute" do
      browser.checkbox(:id, "new_user_interests_dancing").class_name.should == "fun"
    end

    it "returns an emptry string if the checkbox exists and the attribute doesn't" do
      browser.checkbox(:id, "new_user_interests_books").class_name.should == ""
    end

    it "raises UnknownObjectException if the checkbox doesn't exist" do
      lambda { browser.checkbox(:id, "no_such_id").class_name }.should raise_error(UnknownObjectException)
    end
  end

  describe "#id" do
    it "returns the id attribute if the checkbox exists and has an attribute" do
      browser.checkbox(:index, 1).id.should == "new_user_interests_books"
    end

    it "returns an emptry string if the checkbox exists and the attribute doesn't" do
      browser.checkbox(:index, 2).id.should == ""
    end

    it "raises UnknownObjectException if the checkbox doesn't exist" do
      lambda { browser.checkbox(:index, 1337).id }.should raise_error(UnknownObjectException)
    end
  end

  describe "#name" do
    it "returns the name attribute if the checkbox exists" do
      browser.checkbox(:id, 'new_user_interests_books').name.should == "new_user_interests"
    end

    it "returns an empty string if the checkbox exists and the attribute doesn't" do
      browser.checkbox(:id, 'new_user_interests_food').name.should == ""
    end

    it "raises UnknownObjectException if the checkbox doesn't exist" do
      lambda { browser.checkbox(:index, 1337).name }.should raise_error(UnknownObjectException)
    end
  end

  describe "#title" do
    it "returns the title attribute if the checkbox exists" do
      browser.checkbox(:id, "new_user_interests_dancing").title.should == "Dancing is fun!"
    end

    it "returns an emptry string if the checkbox exists and the attribute doesn't" do
      browser.checkbox(:id, "new_user_interests_books").title.should == ""
    end

    it "raises UnknownObjectException if the checkbox doesn't exist" do
      lambda { browser.checkbox(:index, 1337).title }.should raise_error(UnknownObjectException)
    end
  end

  describe "#type" do
    it "returns the type attribute if the checkbox exists" do
      browser.checkbox(:index, 1).type.should == "checkbox"
    end

    it "raises UnknownObjectException if the checkbox doesn't exist" do
      lambda { browser.checkbox(:index, 1337).type }.should raise_error(UnknownObjectException)
    end
  end

  describe "#value" do
    it "returns the value attribute if the checkbox exists" do
      browser.checkbox(:id, 'new_user_interests_books').value.should == 'books'
    end

    it "raises UnknownObjectException if the checkbox doesn't exist" do
      lambda { browser.checkbox(:index, 1337).value}.should raise_error(UnknownObjectException)
    end
  end

  # Access methods

  describe "#enabled?" do
    it "returns true if the checkbox button is enabled" do
      browser.checkbox(:id, "new_user_interests_books").enabled?.should be_true
    end

    it "returns false if the checkbox button is disabled" do
      browser.checkbox(:id, "new_user_interests_dentistry").enabled?.should be_false
    end

    it "raises UnknownObjectException if the checkbox button doesn't exist" do
      lambda { browser.checkbox(:id, "no_such_id").enabled?  }.should raise_error(UnknownObjectException)
      lambda { browser.checkbox(:xpath, "//input[@id='no_such_id']").enabled?  }.should raise_error(UnknownObjectException)
    end
  end

  describe "#disabled?" do
    it "returns true if the checkbox is disabled" do
      browser.checkbox(:id, 'new_user_interests_dentistry').disabled?.should be_true
    end

    it "returns false if the checkbox is enabled" do
      browser.checkbox(:id, 'new_user_interests_books').disabled?.should be_false
    end

    it "raises UnknownObjectException if the checkbox doesn't exist" do
      lambda { browser.checkbox(:index, 1337).disabled? }.should raise_error(UnknownObjectException)
    end
  end

  # Manipulation methods

  describe "#clear" do
    it "raises ObjectDisabledException if the checkbox is disabled" do
      browser.checkbox(:id, "new_user_interests_dentistry").set?.should be_false
      lambda { browser.checkbox(:id, "new_user_interests_dentistry").clear }.should raise_error(ObjectDisabledException)
    end

    it "clears the checkbox button if it is set" do
      browser.checkbox(:id, "new_user_interests_books").clear
      browser.checkbox(:id, "new_user_interests_books").set?.should be_false
    end

    it "clears the checkbox button when found by :xpath" do
      browser.checkbox(:xpath, "//input[@id='new_user_interests_books']").clear
      browser.checkbox(:xpath, "//input[@id='new_user_interests_books']").set?.should be_false
    end

    it "raises UnknownObjectException if the checkbox button doesn't exist" do
      lambda { browser.checkbox(:name, "no_such_id").clear }.should raise_error(UnknownObjectException)
    end
  end

  describe "#set" do
    it "sets the checkbox button" do
      browser.checkbox(:id, "new_user_interests_cars").set
      browser.checkbox(:id, "new_user_interests_cars").set?.should be_true
    end

    it "sets the checkbox button when found by :xpath" do
      browser.checkbox(:xpath, "//input[@id='new_user_interests_cars']").set
      browser.checkbox(:xpath, "//input[@id='new_user_interests_cars']").set?.should be_true
    end

    it "fires the onclick event" do
      browser.button(:id, "disabled_button").should be_disabled
      browser.checkbox(:id, "toggle_button_checkbox").set
      browser.button(:id, "disabled_button").should_not be_disabled
      browser.checkbox(:id, "toggle_button_checkbox").clear
      browser.button(:id, "disabled_button").should be_disabled
    end

    it "raises UnknownObjectException if the checkbox button doesn't exist" do
      lambda { browser.checkbox(:name, "no_such_name").set  }.should raise_error(UnknownObjectException)
    end

    it "raises ObjectDisabledException if the checkbox is disabled" do
      lambda { browser.checkbox(:id, "new_user_interests_dentistry").set  }.should raise_error(ObjectDisabledException)
    end
  end

  # Other

  describe '#set?' do
    it "returns true if the checkbox button is set" do
      browser.checkbox(:id, "new_user_interests_books").set?.should be_true
    end

    it "returns false if the checkbox button unset" do
      browser.checkbox(:id, "new_user_interests_cars").set?.should be_false
    end

    it "raises UnknownObjectException if the checkbox button doesn't exist" do
      lambda { browser.checkbox(:id, "no_such_id").set?  }.should raise_error(UnknownObjectException)
    end
  end

end
