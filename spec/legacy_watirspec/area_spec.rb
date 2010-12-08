# encoding: utf-8
require File.expand_path("../spec_helper", __FILE__)

describe "Area" do

  before :each do
    browser.goto(WatirSpec.files + "/images.html")
  end

  # Exists method
  describe "#exists?" do
    it 'is true if the area exists' do
      browser.area(:id, "NCE").exists?.should be_true
    end

    it 'is false if the area exists' do
      browser.area(:id, "hoobaflooba").exists?.should be_false
    end
  end

  describe "how" do
    it "can be :id" do
      browser.area(:id, "NCE").exists?.should be_true
    end

    it 'can be :name' do
      browser.area(:name, "NCE").exists?.should be_true
    end

    it 'can be :title' do
      browser.area(:title, "Tables").exists?.should be_true
    end

    it 'can be :url' do
      browser.area(:url, "tables.html").exists?.should be_true
    end

    it 'can be :href' do
      browser.area(:href, "tables.html").exists?.should be_true
    end

    it 'can be :index' do
      browser.area(:index, 1).exists?.should be_true
    end

    it 'can be :xpath' do
      browser.area(:xpath, "//area[@id='NCE']").exists?.should be_true
    end

    it "defaults to :id" do
      browser.area("NCE").exists?.should be_true
    end

    it "returns the first area if not given" do
      browser.area.exists?.should be_true
    end

    it "raises TypeError when 'what' argument is invalid" do
      lambda { browser.area(:id, 3.14).exists? }.should raise_error(TypeError)
    end

    it "raises MissingWayOfFindingObjectException when 'how' argument is invalid" do
      lambda { browser.area(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
    end
  end

  # Attribute methods
  describe "#id" do
    it "returns the id attribute" do
      browser.area(:index, 1).id.should == "NCE"
    end

    it "returns an empty string if the element exists and the attribute doesn't" do
      browser.area(:index, 3).id.should == ''
    end

    it "raises UnknownObjectException if the area doesn't exist" do
      lambda { browser.area(:id, "no_such_id").id }.should raise_error(UnknownObjectException)
      lambda { browser.area(:index, 1337).id }.should raise_error(UnknownObjectException)
    end

  end

  describe "#name" do
    it "returns the name attribute" do
      browser.area(:index, 1).name.should == "NCE"
    end

    it "returns an empty string if the element exists and the attribute doesn't" do
      browser.area(:index, 3).name.should == ''
    end

    it "raises UnknownObjectException if the area doesn't exist" do
      lambda { browser.area(:id, "no_such_id").name }.should raise_error(UnknownObjectException)
      lambda { browser.area(:index, 1337).name }.should raise_error(UnknownObjectException)
    end
  end

end
