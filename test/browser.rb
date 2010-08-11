require "operahelper"

describe "browser" do
  # back
  it "should go back" do
    puts "test 1"
#    puts "files: " + files
    browser.goto files + "/foo.html"
#    puts "  after first browser call"
    browser.goto files + "/bar.html"
    browser.back
    browser.text.include?("foo").should == true
  end
=begin
  # goto
  it "should load HTML page" do
    puts "test 2"
    browser.goto files + "/blank.html"
  end

  it "should load about:blank" do
    puts "test 3"
    browser.goto "about:blank"
    browser.text.size.should == 0
  end

  # is_connected
  it "should be connected to a browser instance" do
    puts "test 4"
    browser.is_connected?.should == true
  end

#  it "should not be connected to a browser instance" do
#    @browser.quit
#    @browser.is_connected?.should == false
#  end

  it "should be connected to a browser instance after starting a new instance" do
    puts "test 5"
    browser.is_connected?.should == true
  end

  it "foobar" do
    puts "test 6"
    browser.goto "http://sny.no/"
  end
=end
end

