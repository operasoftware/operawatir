require File.expand_path('../../watirspec_helper', __FILE__)

describe "quick_widget" do
    describe "#open_window_with_hover" do
      it "opens window on hover" do
        browser.quick_window(:name, "Browser Window").quick_toolbar(:name, "Pagebar").quick_tab(:pos, 0).open_window_with_hover.should > 0
      end
    end
    
    describe "#exist?" do
    end
    
    describe "#enabled?" do
    end
      
    describe "#visible?" do
    end

    describe "#text" do
    end
    
    describe "#type" do
    end
    
    describe "#name" do
    end
    
    describe "#to_s" do
    end

    describe "#verify_text" do
    end
  
    describe "#verify_includes_text" do
    end
    
    describe "print_row" do
    end

    describe "#row_info_string" do
    end

    describe "#position" do
    end
    
    describe "#print_widget_info" do
    end

    describe "#widget_info_string" do
    end
          
    describe "#driver" do
    end
    
    describe "#parent_name" do
    end
    
    describe "#focus_with_click" do
    end
    
    describe "#value" do
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