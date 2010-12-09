# encoding: utf-8
require File.expand_path("../spec_helper", __FILE__)

describe "Option" do

  before :each do
    browser.goto(WatirSpec.files + "/forms_with_input_elements.html")
  end

  describe "option" do
    describe "#exists?" do
      it "returns true if the element exists (page context)" do
        bug "WTR-330", :watir do
          browser.option(:id, "nor").should exist
        end

      end

      it "returns false if the element does not exist (page context)" do
        browser.option(:id, "no_such_id").should_not exist
      end
    end

    describe "how" do
      it "can be :value" do
        browser.option(:value, "2").should exist
      end

      it "can be :text" do
        browser.option(:text, "Norway").should exist
      end

      it "can be :class" do
        browser.option(:class, "scandinavia").should exist
      end

      it "can be :index" do
        browser.option(:index, 2).should exist
      end

      it "returns the first option if given no args" do
        browser.option.should exist
      end

      it "defaults to :text" do
        browser.option("Swedish").should exist
      end
    end
  end

  describe "select_list" do
    describe "exists?" do
      it "returns true if the element exists (select_list context)" do
        browser.select_list(:name, "new_user_country").option(:id, "nor").should exist
      end

    it "returns false if the element does not exist (select_list context)" do
        browser.select_list(:name, "new_user_country").option(:id, "no_such_id").should_not exist
      end
    end

    describe "how" do
      it "can be :name" do
        browser.select_list(:name, "new_user_country").option(:value, "2").should exist
      end

      it "defaults to :text" do
        browser.select_list(:name, "new_user_languages").option("Swedish").should exist
      end

      it "raises TypeError when 'what' argument is invalid" do
        lambda { browser.option(:id, 3.14).exists? }.should raise_error(TypeError)
      end

      it "raises MissingWayOfFindingObjectException when 'how' argument is invalid" do
        lambda { browser.option(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
      end
    end
  end

  describe "#select" do
    bug "WTR-367", :watir do
      it "selects the chosen option (page context)" do
        browser.select_list(:name, "new_user_country").clear
        browser.option(:text, "Denmark").select
        browser.select_list(:name, "new_user_country").selected_options.should == ["Denmark"]
      end
    end

    it "selects the chosen option (select_list context)" do
      browser.select_list(:name, "new_user_country").clear
      browser.select_list(:name, "new_user_country").option(:text, "Denmark").select
      browser.select_list(:name, "new_user_country").selected_options.should == ["Denmark"]
    end

    bug "WTR-367, WTR-329", :watir do
      it "selects the option when found by text (page context)" do
        browser.option(:text, 'Sweden').select
        browser.option(:text, 'Sweden').should be_selected
      end

      it "selects the option when found by text (select_list context)" do
        browser.select_list(:name, 'new_user_country').option(:text, 'Sweden').select
        browser.select_list(:name, 'new_user_country').option(:text, 'Sweden').should be_selected
      end
    end

    it "fires the onclick event (page context)" do
      bug "WTR-367, WTR-335", :watir do
        browser.option(:text, "Username 3").select
      end
      browser.text_field(:id, 'delete_user_comment').value.should == 'Don\'t do it!'
    end

    it "fires onclick event (select_list context)" do
      browser.select_list(:id, 'delete_user_username').option(:text, "Username 3").select
      browser.text_field(:id, 'delete_user_comment').value.should == 'Don\'t do it!'
    end

    bug "WTR-367", :watir do
      it "raises UnknownObjectException if the option does not exist (page context)" do
        lambda { browser.option(:text, "no_such_text").select }.should raise_error(UnknownObjectException)
      end
    end

    it "raises UnknownObjectException if the option does not exist (select_list context)" do
      lambda { browser.select_list(:name, "new_user_country").option(:text, "no_such_text").select }.should raise_error(UnknownObjectException)
      lambda { browser.select_list(:name, "new_user_country").option(:text, /missing/).select }.should raise_error(UnknownObjectException)
    end

    bug "WTR-367", :watir do
      it "raises MissingWayOfFindingObjectException when given a bad 'how' (page context)" do
        lambda { browser.option(:missing, "Denmark").select }.should raise_error(MissingWayOfFindingObjectException)
      end
    end

    it "raises MissingWayOfFindingObjectException when given a bad 'how' (select_list context)" do
      lambda { browser.select_list(:name, "new_user_country").option(:missing, "Denmark").select }.should raise_error(MissingWayOfFindingObjectException)
    end
  end

  bug "WTR-331", :watir do
    describe "#class_name" do
      bug "WTR-367", :watir do
        it "is able to get attributes (page context)" do
          browser.option(:text, 'Sweden').class_name.should == "scandinavia"
        end
      end

      it "is able to get attributes (select_list context)" do
        browser.select_list(:name, "new_user_country").option(:text , 'Sweden').class_name.should == "scandinavia"
      end
    end
  end
end
