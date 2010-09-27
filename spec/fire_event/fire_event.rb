require "operawatir/helper"

describe "fire_event" do
  before(:all) do
    OperaWatir::Helper.files = "file:///home/andreastt/tmp/fire_event/"
  end

  # onMouseOver 
  it "should fire event onMouseOver with symbol" do
    browser.goto files + "onMouseOver.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onMouseOver) }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onMouseOver with lowercase symbol" do
    browser.goto files + "onMouseOver.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onmouseover) }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onMouseOver with string" do
    browser.goto files + "onMouseOver.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onMouseOver") }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onMouseOver with lowercase string" do
    browser.goto files + "onMouseOut.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onmouseover") }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end


  # onMouseOut
  it "should fire event onMouseOut with symbol" do
    browser.goto files + "onMouseOut.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onMouseOut) }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onMouseOut with lowercase symbol" do
    browser.goto files + "onMouseOut.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onmouseout) }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onMouseOut with string" do
    browser.goto files + "onMouseOut.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onMouseOut") }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onMouseOut with lowercase string" do
    browser.goto files + "onMouseOut.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onmouseout") }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end


  # onMouseDown
  it "should fire event onMouseDown with symbol" do
    browser.goto files + "onMouseDown.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onMouseDown) }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onMouseDown with lowercase symbol" do
    browser.goto files + "onMouseDown.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onmousedown) }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onMouseDown with string" do
    browser.goto files + "onMouseDown.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onMouseDown") }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onMouseDown with lowercase string" do
    browser.goto files + "onMouseDown.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onmousedown") }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end


  # onMouseUp
  it "should fire event onMouseUp with symbol" do
    browser.goto files + "onMouseUp.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onMouseUp) }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onMouseUp with lowercase symbol" do
    browser.goto files + "onMouseUp.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onmouseup) }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onMouseUp with string" do
    browser.goto files + "onMouseUp.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onMouseUp") }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onMouseUp with lowercase string" do
    browser.goto files + "onMouseUp.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onmouseup") }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end


  # onMouseMove
  it "should fire event onMouseMove with symbol" do
    browser.goto files + "onMouseMove.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onMouseMove) }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onMouseMove with lowercase symbol" do
    browser.goto files + "onMouseMove.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onmousemove) }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onMouseMove with string" do
    browser.goto files + "onMouseMove.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onMouseMove") }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onMouseMove with lowercase string" do
    browser.goto files + "onMouseMove.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onmousemove") }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end


  # onClick
  it "should fire event onClick with symbol" do
    browser.goto files + "onClick.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onClick) }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onClick with lowercase symbol" do
    browser.goto files + "onClick.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onclick) }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onClick with string" do
    browser.goto files + "onClick.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onClick") }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onClick with lowercase string" do
    browser.goto files + "onClick.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onclick") }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end


  # onDblClick
  it "should fire event onDblClick with symbol" do
    browser.goto files + "onDblClick.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onDblClick) }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onDblClick with lowercase symbol" do
    browser.goto files + "onDblClick.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:ondblclick) }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onDblClick with string" do
    browser.goto files + "onDblClick.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onDblClick") }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onDblClick with lowercase string" do
    browser.goto files + "onDblClick.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("ondblclick") }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end


  # FIXME: onAbort

 
  # onBlur
  it "should fire event onBlur with symbol" do
    browser.goto files + "onBlur.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onBlur) }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onBlur with lowercase symbol" do
    browser.goto files + "onBlur.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onblur) }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onBlur with string" do
    browser.goto files + "onBlur.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onBlur") }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onBlur with lowercase string" do
    browser.goto files + "onBlur.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onblur") }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end


  # onChange
  it "should fire event onChange with symbol" do
    browser.goto files + "onChange.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onChange) }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onChange with lowercase symbol" do
    browser.goto files + "onChange.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onchange) }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onChange with string" do
    browser.goto files + "onChange.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onChange") }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onChange with lowercase string" do
    browser.goto files + "onChange.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onchange") }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end


  # onFocus
  it "should fire event onFocus with symbol" do
    browser.goto files + "onFocus.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onFocus) }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onFocus with lowercase symbol" do
    browser.goto files + "onFocus.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onfocus) }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onFocus with string" do
    browser.goto files + "onFocus.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onFocus") }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

  it "should fire event onFocus with lowercase string" do
    browser.goto files + "onFocus.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onfocus") }
    browser.p(:id, "result").verify_contains("PASS").should == true
  end


  # FIXME: onLoad


  # FIXME:  onReset


  # FIXME:  onResize


  # FIXME:  onScroll


  # FIXME:  onSelect


  # FIXME:  onSubmit


  # FIXME:  onUnload

end

