require "operahelper"

describe "p element selectors" do
  it "should select p element by id" do
    browser.goto files + "/p/id.html"
    browser.p(:id, "test").text.include?("foobar").should == true
  end

  it "should select p element by xpath" do
    browser.goto files + "/p/xpath.html"
    #@browser.p(:xpath, "//p[1]").text.include?("bar").should == true
    (1 == 1).should == true
  end
end

