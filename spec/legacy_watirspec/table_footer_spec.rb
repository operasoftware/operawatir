# encoding: utf-8
require File.expand_path("../spec_helper", __FILE__)

describe "TableFooter" do
  before :each do
    browser.goto(WatirSpec.files + "/tables.html")
  end

  describe 'page' do
    describe "#exists?" do
      it "returns true if the table tfoot exists (page context)" do
        browser.tfoot(:id, 'tax_totals').exists?.should be_true
      end

      it "returns false if the table tfoot doesn't exist (page context)" do
        browser.tfoot(:id, 'no_such_id').should_not exist
      end

    end

    describe "how" do
      it "can be :id" do
        browser.tfoot(:id, 'tax_totals').exists?.should be_true
      end

      it "can be :index" do
        browser.tfoot(:index, 1).exists?.should be_true
      end

      it "can be :xpath" do
        browser.tfoot(:xpath, "//tfoot[@id='tax_totals']").exists?.should be_true
      end

      it "returns the first tfoot if given no args" do
        browser.tfoot.exists?.should be_true
      end

      it "defaults to :id" do
        browser.tfoot("tax_totals").exists?.should be_true
      end

      it "raises TypeError when 'what' argument is invalid" do
        lambda { browser.tfoot(:id, 3.14).exists? }.should raise_error(TypeError)
      end

      it "raises MissingWayOfFindingObjectException when 'how' argument is invalid" do
        lambda { browser.tfoot(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
      end
    end
  end

  describe 'table' do

    describe "#exists?" do
      it "returns true if the table tfoot exists (table context)" do
        browser.table(:index, 1).tfoot(:id, 'tax_totals').exists?.should be_true
      end

      it "returns false if the table tfoot doesn't exist (table context)" do
        browser.table(:index, 1).tfoot(:id, 'no_such_id').should_not exist
      end
    end

    describe "how" do
      it "can be :id" do
        browser.table(:index, 1).tfoot(:id, 'tax_totals').exists?.should be_true
      end

      it "can be :index" do
        browser.table(:index, 1).tfoot(:index, 1).exists?.should be_true
      end

      it "can be :xpath" do
        browser.table(:index, 1).tfoot(:xpath, "//tfoot[@id='tax_totals']").exists?.should be_true
      end

      it "returns true if the element exists (default how = :id)" do
        browser.table(:index, 1).tfoot("tax_totals").exists?.should be_true
      end

      it "raises TypeError when 'what' argument is invalid" do
        lambda { browser.table(:index, 1).tfoot(:id, 3.14).exists? }.should raise_error(TypeError)
      end

      it "raises MissingWayOfFindingObjectException when 'how' argument is invalid" do
        lambda { browser.table(:index, 1).tfoot(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
      end
    end
  end

  describe "#length" do
    it "returns the correct number of table footers (page context)" do
      browser.tfoot(:id, 'tax_totals').length.should == 1
    end

    it "returns the correct number of table footers (table context)" do
      browser.table(:index, 1).tfoot(:id, 'tax_totals').length.should == 1
    end
  end

  describe "#[]" do
    it "returns the row at the given index (page context)" do
      browser.tfoot(:id, 'tax_totals')[1].id.should == 'tfoot_row_1'
      browser.tfoot(:id, 'tax_totals')[1][2].text.should == '24 349'
      browser.tfoot(:id, 'tax_totals')[1][3].text.should == '5 577'
    end

    it "returns the row at the given index (table context)" do
      browser.table(:index, 1).tfoot(:id, 'tax_totals')[1].id.should == "tfoot_row_1"
      browser.table(:index, 1).tfoot(:id, 'tax_totals')[1][2].text.should == '24 349'
      browser.table(:index, 1).tfoot(:id, 'tax_totals')[1][3].text.should == '5 577'
    end
  end

  describe "#each" do
    it "iterates through rows correctly" do
      tfoot = browser.table(:index, 1).tfoot(:id, 'tax_totals')
      tfoot.each_with_index do |r, idx|
        r.id.should == "tfoot_row_#{idx + 1}"
      end
    end
  end
end
