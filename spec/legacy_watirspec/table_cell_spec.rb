# encoding: utf-8
require File.expand_path("../spec_helper", __FILE__)

describe "TableCell" do

  before :each do
    browser.goto(WatirSpec.files + "/tables.html")
  end

  # Exists
  describe "#exists?" do
    it "returns true when the table cell exists" do
      browser.cell(:id, 't1_r2_c1').exists?.should be_true
    end
    it "returns false when the table cell does not exist" do
      browser.cell(:id, 'no_such_id').should_not exist
    end
  end

  describe "how" do
    it "can be :id" do
      browser.cell(:id, 't1_r2_c1').exists?.should be_true
    end

    it "can be :text" do
      browser.cell(:text, 'Table 1, Row 3, Cell 1').exists?.should be_true
    end

    it "can be :index" do
      browser.cell(:index, 1).exists?.should be_true
    end

    it "can be :xpath" do
      browser.cell(:xpath, "//td[@id='t1_r2_c1']").exists?.should be_true
    end

    it "returns true if the element exists (default how = :id)" do
      browser.cell("t1_r2_c1").exists?.should be_true
    end

    it "returns the first cell if given no args" do
      browser.cell.exists?.should be_true
    end

    it "raises TypeError when 'what' argument is invalid" do
      lambda { browser.cell(:id, 3.14).exists? }.should raise_error(TypeError)
    end

    it "raises MissingWayOfFindingObjectException when 'how' argument is invalid" do
      lambda { browser.cell(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
    end
  end

  describe "#click" do
    it "fires the table's onclick event" do
      browser.cell(:id, 't2_r1_c1').click
      messages.should include('td')
    end
  end

  # Attribute methods
  describe "#text" do
    it "returns the text inside the table cell" do
      browser.cell(:id, 't1_r2_c1').text.should == 'Table 1, Row 2, Cell 1'
      browser.cell(:id, 't2_r1_c1').text.should == 'Table 2, Row 1, Cell 1'
    end
  end

  describe "#colspan" do
    it "gets the colspan attribute" do
      browser.cell(:id, 'colspan_2').colspan.should == 2
      browser.cell(:id, 'no_colspan').colspan.should == 1
    end
  end
end
