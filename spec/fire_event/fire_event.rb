require "operawatir/helper"

describe "fire_event" do
  after(:each) do
    browser.p(:id, "result").verify_contains("PASS").should == true
  end

=begin
  # onMouseOver 
  it "should fire event onMouseOver with symbol" do
    browser.goto files + "onMouseOver.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onMouseOver) }
  end

  it "should fire event onMouseOver with lowercase symbol" do
    browser.goto files + "onMouseOver.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onmouseover) }
  end

  it "should fire event onMouseOver with string" do
    browser.goto files + "onMouseOver.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onMouseOver") }
  end

  it "should fire event onMouseOver with lowercase string" do
    browser.goto files + "onMouseOut.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onmouseover") }
  end


  # onMouseOut
  it "should fire event onMouseOut with symbol" do
    browser.goto files + "onMouseOut.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onMouseOut) }
  end

  it "should fire event onMouseOut with lowercase symbol" do
    browser.goto files + "onMouseOut.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onmouseout) }
  end

  it "should fire event onMouseOut with string" do
    browser.goto files + "onMouseOut.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onMouseOut") }
  end

  it "should fire event onMouseOut with lowercase string" do
    browser.goto files + "onMouseOut.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onmouseout") }
  end


  # onMouseDown
  it "should fire event onMouseDown with symbol" do
    browser.goto files + "onMouseDown.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onMouseDown) }
  end

  it "should fire event onMouseDown with lowercase symbol" do
    browser.goto files + "onMouseDown.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onmousedown) }
  end

  it "should fire event onMouseDown with string" do
    browser.goto files + "onMouseDown.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onMouseDown") }
  end

  it "should fire event onMouseDown with lowercase string" do
    browser.goto files + "onMouseDown.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onmousedown") }
  end


  # onMouseUp
  it "should fire event onMouseUp with symbol" do
    browser.goto files + "onMouseUp.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onMouseUp) }
  end

  it "should fire event onMouseUp with lowercase symbol" do
    browser.goto files + "onMouseUp.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onmouseup) }
  end

  it "should fire event onMouseUp with string" do
    browser.goto files + "onMouseUp.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onMouseUp") }
  end

  it "should fire event onMouseUp with lowercase string" do
    browser.goto files + "onMouseUp.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onmouseup") }
  end


  # onMouseMove
  it "should fire event onMouseMove with symbol" do
    browser.goto files + "onMouseMove.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onMouseMove) }
  end

  it "should fire event onMouseMove with lowercase symbol" do
    browser.goto files + "onMouseMove.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onmousemove) }
  end

  it "should fire event onMouseMove with string" do
    browser.goto files + "onMouseMove.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onMouseMove") }
  end

  it "should fire event onMouseMove with lowercase string" do
    browser.goto files + "onMouseMove.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onmousemove") }
  end


  # onClick
  it "should fire event onClick with symbol" do
    browser.goto files + "onClick.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onClick) }
  end

  it "should fire event onClick with lowercase symbol" do
    browser.goto files + "onClick.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onclick) }
  end

  it "should fire event onClick with string" do
    browser.goto files + "onClick.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onClick") }
  end

  it "should fire event onClick with lowercase string" do
    browser.goto files + "onClick.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onclick") }
  end


  # onDblClick
  it "should fire event onDblClick with symbol" do
    browser.goto files + "onDblClick.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onDblClick) }
  end

  it "should fire event onDblClick with lowercase symbol" do
    browser.goto files + "onDblClick.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:ondblclick) }
  end

  it "should fire event onDblClick with string" do
    browser.goto files + "onDblClick.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onDblClick") }
  end

  it "should fire event onDblClick with lowercase string" do
    browser.goto files + "onDblClick.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("ondblclick") }
  end


  # onAbort cannot be automated using Watir.

 
  # onBlur
  it "should fire event onBlur with symbol" do
    browser.goto files + "onBlur.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onBlur) }
  end

  it "should fire event onBlur with lowercase symbol" do
    browser.goto files + "onBlur.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onblur) }
  end

  it "should fire event onBlur with string" do
    browser.goto files + "onBlur.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onBlur") }
  end

  it "should fire event onBlur with lowercase string" do
    browser.goto files + "onBlur.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onblur") }
  end


  # onChange
  it "should fire event onChange with symbol" do
    browser.goto files + "onChange.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onChange) }
  end

  it "should fire event onChange with lowercase symbol" do
    browser.goto files + "onChange.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onchange) }
  end

  it "should fire event onChange with string" do
    browser.goto files + "onChange.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onChange") }
  end

  it "should fire event onChange with lowercase string" do
    browser.goto files + "onChange.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onchange") }
  end


  # onFocus
  it "should fire event onFocus with symbol" do
    browser.goto files + "onFocus.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onFocus) }
  end

  it "should fire event onFocus with lowercase symbol" do
    browser.goto files + "onFocus.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event(:onfocus) }
  end

  it "should fire event onFocus with string" do
    browser.goto files + "onFocus.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onFocus") }
  end

  it "should fire event onFocus with lowercase string" do
    browser.goto files + "onFocus.html"
    browser.elements(:xpath, "//form/*").each { |e| e.fire_event("onfocus") }
  end
=end

  # FIXME: onLoad


  # FIXME:  onReset


  # FIXME:  onResize


  # FIXME:  onScroll
  it "should fire event onScroll with symbol" do
    browser.goto files + "onScroll.html"
    browser.element(:xpath, "//body").fire_event(:onScroll)
  end

  it "should fire event onScroll with lowercase symbol" do
    browser.goto files + "onScroll.html"
    browser.element(:xpath, "//body").fire_event(:onscroll)
  end

  it "should fire event onScroll with string" do
    browser.goto files + "onScroll.html"
    browser.element(:xpath, "//body").fire_event("onScroll")
  end

  it "should fire event onScroll with lowercase string" do
    browser.goto files + "onScroll.html"
    browser.element(:xpath, "//body").fire_event("onscroll")
  end


  # FIXME:  onSelect


  # FIXME:  onSubmit


  # FIXME:  onUnload
end

