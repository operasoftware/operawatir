# encoding: utf-8
require File.expand_path("../spec_helper", __FILE__)

describe "Dl" do

  before :each do
    browser.goto(WatirSpec.files + "/definition_lists.html")
  end

  # Exists method
  describe "#exists?" do
    it "returns true if the element exists" do
      browser.dl(:id, "experience-list").exists?.should be_true
    end

    it "returns false if the element does not exist" do
      browser.dl(:id, "no_such_id").should_not exist
    end
  end

  describe "how" do
    it "can be :id" do
      browser.dl(:id, "experience-list").exists?.should be_true
    end

    it "can be :class" do
      browser.dl(:class, "list").exists?.should be_true
    end

    it "can be :xpath" do
      browser.dl(:xpath, "//dl[@id='experience-list']").exists?.should be_true
    end

    it "can be :index" do
      browser.dl(:index, 1).exists?.should be_true
    end

    it "returns the first dl if not given" do
      browser.dl.exists?.should be_true
    end

    it "raises TypeError when 'what' argument is invalid" do
      lambda { browser.dl(:id, 3.14).exists? }.should raise_error(TypeError)
    end

    it "raises MissingWayOfFindingObjectException when 'how' argument is invalid" do
      lambda { browser.dl(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
    end
  end

  # Attribute methods
  describe "#class_name" do
    it "returns the class attribute if the element exists" do
      browser.dl(:id , "experience-list").class_name.should == "list"
    end

    it "returns an empty string if the element exists but the attribute doesn't" do
      browser.dl(:id , "noop").class_name.should == ""
    end

    it "raises UnknownObjectException if the element does not exist" do
      lambda { browser.dl(:id, "no_such_id").class_name }.should raise_error(UnknownObjectException)
    end
  end

  describe "#id" do
    it "returns the id attribute if the element exists" do
      browser.dl(:class, 'list').id.should == "experience-list"
    end

    it "returns an empty string if the element exists, but the attribute doesn't" do
      browser.dl(:class, 'personalia').id.should == ""
    end

    it "raises UnknownObjectException if the element does not exist" do
      lambda {browser.dl(:id, "no_such_id").id }.should raise_error(UnknownObjectException)
    end
  end

  describe "#title" do
    it "returns the id attribute if the element exists" do
      browser.dl(:class, 'list').title.should == "experience"
    end
  end

  describe "#text" do
    it "returns the text of the element" do
      browser.dl(:id, "experience-list").text.should include("11 years")
    end

    it "returns an empty string if the element exists but contains no text" do
      browser.dl(:id, 'noop').text.should == ""
    end

    it "raises UnknownObjectException if the element does not exist" do
      lambda { browser.dl(:id, "no_such_id").text }.should raise_error(UnknownObjectException)
    end
  end

  # Manipulation methods
  describe "#click" do
    it "fires events when clicked" do
      browser.dl(:id, 'noop').text.should_not == 'noop'
      browser.dl(:id, 'noop').click
      browser.dl(:id, 'noop').text.should == 'noop'
    end

    it "raises UnknownObjectException if the element does not exist" do
      lambda { browser.dl(:id, "no_such_id").click }.should raise_error(UnknownObjectException)
    end
  end

  describe "#html" do
    it "returns the HTML of the element" do
      html = browser.dl(:id, 'experience-list').html
      html.should include('<dt class="current-industry">')
      html.should_not include('</body>')
    end
  end

  describe "#to_s" do
    bug "WTR-350", :watir do
      it "returns a human readable representation of the element" do
        browser.dl(:id, 'experience-list').to_s.should ==
%q{tag:          dl
  id:           experience-list
  class:        list
  title:        experience
  text:         Experience 11 years Education Master Current industry Architecture Previous industry experience Architecture}
      end
    end
  end

end
