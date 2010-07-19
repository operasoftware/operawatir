require "operahelper"

describe "p element actions" do
  it "should be enabled" do
    @browser.goto @url + "foobar.html"
    @browser.p(:xpath, "//p[1]").enabled?.should == true
  end

  it "should exist" do
    @browser.goto @url + "p/exists.html"
    @browser.p(:id, "one").exists?.should == true
    @browser.p(:id, "two").exists?.should == true
    @browser.p(:id, "four").exists?.should == true
    @browser.p(:id, "five").exists?.should == true
  end

  it "should not exist" do
    @browser.goto @url + "p/exists.html"
    @browser.p(:id, "three").exists?.should == false
  end

  it "should not be able to clear innerHTML" do
    @browser.goto @url + "foobar.html"
    @browser.p(:xpath, "//p[1]").clear
    @browser.p(:xpath, "//p[1]").text.include?("foobar").should == true
  end
end

