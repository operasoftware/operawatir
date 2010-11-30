# encoding: utf-8
require File.expand_path("../spec_helper", __FILE__)

describe "Button" do

  before :each do
    browser.goto(WatirSpec.files + "/forms_with_input_elements.html")
  end

  # Exists method
  describe '#exists?' do
    it 'is true if the button exists' do
      browser.button(:id, "new_user_submit").exists?.should be_true
    end

    it 'is false if the button exists' do
      browser.button(:id, "hoobaflooba").exists?.should be_false
    end
  end

  describe "how" do
    it "can be :id" do
      browser.button(:id, "new_user_submit").should exist
    end

    it "can be :name" do
      browser.button(:name, "new_user_reset").should exist
    end

    it "can be :value" do
      browser.button(:value, "Button 2").should exist
    end

    it "can be :src" do
      browser.button(:src, "images/button.jpg").should exist
    end

    it "can be :text" do
      browser.button(:text, "Button 2").should exist
    end

    it "can be :class" do
      browser.button(:class, "image").should exist
    end

    it "can be :index" do
      browser.button(:index, 1).should exist
    end

    it "can be :xpath" do
      browser.button(:xpath, "//input[@id='new_user_submit']").should exist
    end

    it "can be :alt" do
      browser.button(:alt, "Create a new user").should exist
    end

    it "can be :caption" do
      browser.button(:caption, "Button 2").should exist
    end

    it "defaults to :value" do
      browser.button("Submit").should exist
    end

    it "returns the first button if not given" do
      browser.button.should exist
    end

    it "raises TypeError when 'what' argument is invalid" do
      lambda { browser.button(:id, 3.14).exists? }.should raise_error(TypeError)
    end

    it "raises MissingWayOfFindingObjectException when 'how' argument is invalid" do
      lambda { browser.button(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
    end
  end

  # Attribute methods
  describe "#class_name" do
    it "returns all classes of the button" do
      browser.button(:name, "new_user_image").class_name.should == "image test"
    end

    it "returns an empty string if the button has no class name" do
      browser.button(:name, "new_user_submit").class_name.should == ""
    end
  end

  describe "#id" do
    it "returns the id if the button exists" do
      browser.button(:id, "new_user_submit").should exist.id.should == 'new_user_submit'
    end

    it "raises UnknownObjectException if button does not exist" do
      lambda { browser.button(:index, 1337).id }.should raise_error(UnknownObjectException, 'Unable to locate Button, using :index and 1337')
    end
  end

  describe "#name" do
    it "returns the name if button exists" do
      browser.button(:id, "new_user_submit").name.should == 'new_user_submit'
    end

    it "raises UnknownObjectException if the button does not exist" do
      lambda { browser.button(:name, "no_such_name").name }.should raise_error(UnknownObjectException, 'Unable to locate Button, using :name and "no_such_name"')
    end
  end

  describe "#src" do
    not_compliant_on :watir do
      it "returns the src attribute for the button image" do
        browser.button(:name, "new_user_image").src.should == "images/button.jpg"
      end
    end

    deviates_on :watir do
      it "returns the full url for the button image" do
        browser.button(:name, "new_user_image").src.should == "file:///#{File.dirname(__FILE__)}/images/button.jpg"
      end
    end

    it "raises UnknownObjectException if the button does not exist" do
      lambda { browser.button(:name, "no_such_name").src }.should raise_error(UnknownObjectException, 'Unable to locate Button, using :name and "no_such_name"')
    end
  end

  describe "#style" do
    deviates_on :watir do
      it "returns the style attribute if the button exists" do
        browser.button(:id, 'delete_user_submit').style.should == "border-right: red 4px solid; border-top: red 4px solid; border-left: red 4px solid; border-bottom: red 4px solid"
      end
    end

    not_compliant_on :watir do
      it "returns the style attribute if the button exists" do
        browser.button(:id, 'delete_user_submit').style.should == "border: 4px solid red;"
      end
    end

    it "returns an empty string if the element exists and the attribute doesn't exist" do
      browser.button(:id, 'new_user_submit').style.should == ""
    end

    it "raises UnknownObjectException if the button does not exist" do
      lambda { browser.button(:name, "no_such_name").style }.should raise_error(UnknownObjectException, 'Unable to locate Button, using :name and "no_such_name"')
    end
  end

  describe "#title" do
    it "returns the title of the button" do
      browser.button(:index, 1).title.should == 'Submit the form'
    end

    it "returns an empty string for button without title" do
      browser.button(:index, 2).title.should == ''
    end
  end

  describe "#type" do
    it "returns the type if button exists" do
      browser.button(:index, 1).type.should == 'submit'
      browser.button(:index, 2).type.should == 'reset'
      browser.button(:index, 3).type.should == 'button'
    end

    it "raises UnknownObjectException if button does not exist" do
      lambda { browser.button(:name, "no_such_name").type }.should raise_error(UnknownObjectException, 'Unable to locate Button, using :name and "no_such_name"')
    end
  end

  describe "#value" do
    it "returns the value if button exists" do
      browser.button(:index, 1).value.should == 'Submit'
      browser.button(:index, 2).value.should == 'Reset'
      browser.button(:index, 3).value.should == 'Button'
    end

    it "raises UnknownObjectException if button does not exist" do
      lambda { browser.button(:name, "no_such_name").value }.should raise_error(UnknownObjectException, 'Unable to locate Button, using :name and "no_such_name"')
    end
  end

  describe "#text" do
    it "returns the text of the button" do
      browser.button(:index, 1).text.should == 'Submit'
      browser.button(:index, 2).text.should == 'Reset'
      browser.button(:index, 3).text.should == 'Button'
      browser.button(:index, 4).text.should == "Button 2"
    end

    it "raises UnknownObjectException if the element does not exist" do
      lambda { browser.button(:id, "no_such_id").text }.should raise_error(UnknownObjectException)
    end
  end

  # Access methods
  describe "#enabled?" do
    it "returns true if the button is enabled" do
      browser.button(:name, 'new_user_submit').enabled?.should be_true
    end

    it "returns false if the button is disabled" do
      browser.button(:name, 'new_user_submit_disabled').enabled?.should be_false
    end

    it "raises UnknownObjectException if the button doesn't exist" do
      lambda { browser.button(:name, "no_such_name").enabled? }.should raise_error(UnknownObjectException, 'Unable to locate Button, using :name and "no_such_name"')
    end
  end

  describe "#disabled?" do
    it "returns false when button is enabled" do
      browser.button(:name, 'new_user_submit').disabled?.should be_false
    end

    it "returns true when button is disabled" do
      browser.button(:name, 'new_user_submit_disabled').disabled?.should be_true
    end

    it "raises UnknownObjectException if button does not exist" do
      lambda { browser.button(:name, "no_such_name").disabled? }.should raise_error(UnknownObjectException, 'Unable to locate Button, using :name and "no_such_name"')
    end
  end

  # Manipulation methods
  describe "#click" do
    it "clicks the button if it exists" do
      browser.button(:id, 'new_user_submit').click
      browser.text.should include("You posted the following content:")
    end

    it "fires events" do
      browser.button(:id, 'new_user_button').click
      browser.button(:id, 'new_user_button').value.should == 'new_value_set_by_onclick_event'
    end

    it "raises UnknownObjectException when clicking a button that doesn't exist" do
      lambda { browser.button(:value, "no_such_value").click }.should raise_error(UnknownObjectException, 'Unable to locate Button, using :value and "no_such_value"')
      lambda { browser.button(:id, "no_such_id").click }.should raise_error(UnknownObjectException, 'Unable to locate Button, using :id and "no_such_id"')
    end

    it "raises ObjectDisabledException when clicking a disabled button" do
      lambda { browser.button(:value, "Disabled").click }.should raise_error(ObjectDisabledException)
    end
  end


end
