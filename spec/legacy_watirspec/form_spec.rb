# encoding: utf-8
require File.expand_path("../spec_helper", __FILE__)

describe "Form" do

  before :each do
   browser.goto(WatirSpec.files + "/forms_with_input_elements.html")
  end

  describe "#exists?" do
    it "returns true if the form exists" do
      browser.form(:id, 'new_user').exists?.should be_true
    end

    it "returns false if the form doesn't exist" do
      browser.form(:id, 'no_such_id').should_not exist
      browser.form(:id, /no_such_id/).should_not exist
    end
  end

  describe "how" do
    it "can be :method" do
      browser.form(:method, 'post').exists?.should be_true
    end

    it "can be :action" do
      browser.form(:action, 'post_to_me').exists?.should be_true
    end

    it "can be :index" do
      browser.form(:index, 1).exists?.should be_true
    end

    it "can be :xpath" do
      browser.form(:xpath, "//form[@id='new_user']").exists?.should be_true
    end

    it "returns the first form if given no args" do
      browser.form.exists?.should be_true
    end

    it "defaults to :name)" do
      browser.form("user_new").exists?.should be_true
    end

    it "raises TypeError when 'what' argument is invalid" do
      lambda { browser.form(:id, 3.14).exists? }.should raise_error(TypeError)
    end

    it "raises MissingWayOfFindingObjectException when 'how' argument is invalid" do
      lambda { browser.form(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
    end
  end

  describe "#submit" do
    not_compliant_on :celerity do
      it "submits the form" do
        browser.form(:id, "delete_user").submit
        browser.text.should include("Semantic table")
      end
    end
  end

end
