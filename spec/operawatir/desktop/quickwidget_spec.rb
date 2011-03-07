require File.expand_path('../../watirspec_desktophelper', __FILE__)

describe "QuickWidget" do
    describe "#open_window_with_hover" do
      it "opens window on hover" do
        browser.quick_window(:name, "Browser Window").quick_toolbar(:name, "Pagebar").quick_tab(:pos, 0).open_window_with_hover.should > 0
      end
    end
    
    describe "#type" do
    end
 
    describe "#verify_text" do
    end
  
    describe "#verify_includes_text" do
    end
    
    describe "print_row" do
    end

    describe "#print_widget_info" do
    end

    describe "#focus_with_click" do
    end
    
    #describe "#element" do
    #end
  
    #describe "#drag_and_drop_on" do
    #end

    #describe "#parent_widget" do
    #end

    #describe "#row" do
    #end

    #describe "#col" do
    #end
    
    #def window_id
    #end
    
    #describe "#click" do
    #end
    
    #describe "#right_click" do
    #end
    
    #describe "#double_click" do
    #end
    
    #describe "#set_selector" do
    #end
    
    #describe "#find" do
    #end
end