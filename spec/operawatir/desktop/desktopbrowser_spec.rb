# encoding: utf-8
require File.expand_path('../../watirspec_helper', __FILE__)

describe 'DesktopBrowser' do
  before :all do
    browser.url = fixture('simple.html')
    #@window = browser.quick_window(:name, "Tab 0")
  end
  
  describe "#goto" do
    it "loads page"
  end
  
  describe "#quit_opera" do
    it "quits opera without quitting driver"
  end
  
  describe "#quit_driver" do
    it "quits driver"
  end
  
  describe "#restart" do
    it "quits and restarts opera"
  end

  describe "open and load window" do
    after(:each) do
      browser.close_all_tabs
    end
    
    describe "#open_window_with_action" do
      it "opens new window" do
        browser.open_window_with_action("Document Window", "New page", "1").should open_window
      end
    
      it "fails for actions not opening a new window"
    end
     
    describe "#load_window_with_action" do
      it "loads window" do
        browser.load_window_with_action("Document Window", "Open url in new page", WatirSpec.files + "/boxes.html").should > 0
      end
      it "fails for actions not loading"
    end

    describe "#open_window_with_key_press" do
      it "opens window" do
        browser.open_window_with_key_press("Document Window", "t", :ctrl).should > 0
      end
    end
  end
  
  describe "close window" do
    before(:each) do
      browser.open_window_with_key_press("Document Window", "t", :ctrl).should > 0
    end
    
    describe "#close_window_with_action" do
      it "closes window" do
        browser.close_window_with_action("Document Window", "Close page").should > 0
      end
    end
   
    describe "#close_window_with_key_press" do
      it "closes window" do
        browser.close_window_with_key_press("Document Window", "w", :ctrl).should > 0
      end
    end
   end

   describe "open dialogs" do
     after(:each) do
       browser.close_all_dialogs
     end
    describe "#open_dialog_with_url" do
      it "opens dialog"
    end
    
    describe "#open_dialog_with_click" do
      it "opens dialog"
    end
    
   end
  
   describe "close dialogs" do
     before(:each) do
       browser.open_dialog_with_key_press("New Preferences Dialog", "F12", :ctrl)
     end
    
    describe "#close_dialog" do
      it "closes dialog" do
        browser.close_dialog("New Preferences Dialog").should > 0
      end
    end
   

    describe "#close_all_dialogs" do
      it "closes all dialogs" do
        browser.close_all_dialogs
        browser.quick_windows.select { |win| win.type == "Dialog" }.should be_empty
      end
    end
  end
   
  describe "#activate_tab_with_key_press" do
    it "activates tab"
  end
     
   describe "#set_alignment_with_action" do
     it "sets alignment"
   end

   describe "#widgets" do
     it "retrieves all widgets" do
       browser.widgets("Browser Window").should_not be_empty
     end
     it "retrieves only windows"
   end
  
   describe "#quick_windows" do
     it "retrieves all windows" do
       browser.quick_windows.should_not be_empty
     end
     it "retrieves only windows"
   end
   
   describe "#open_pages" do
     it "holds open tabs" do
       browser.open_pages.should_not be_empty
     end
   end
   
  describe "#quick_buttons" do
    it "retrieves buttons" do
      browser.quick_buttons("Document Window").should_not be_empty
    end
  end
  
  describe "#quick_tabbuttons" do
    it "retrieves tabbuttons" do
      browser.quick_tabbuttons("Browser Window").should_not be_empty
    end
  end
  
  #TODO: Add all other collection types
   
   describe "#window_name" do 
     it "returns empty string for invalid id" do
       browser.window_name(-1).should be_empty
     end
     
     it "returns window name for valid id" do
       valid_id = browser.open_window_with_key_press("Document Window", "t", :ctrl)
       browser.window_name(valid_id).should == "Document Window"
     end
   end
    
   describe "#load_page_with_key_press" do
     it "load page"
   end
   
   describe "#path" do
     it "is not be empty" do
       browser.path.should_not be_empty
     end
   end

   describe "#large_preferences_path" do
     it "is not be empty" do
       browser.large_preferences_path.should_not be_empty
     end
   end
 
   describe "#small_preferences_path" do
     it "returns path" do
       browser.small_preferences_path.should_not be_empty
     end
   end
 
   describe "#cache_preferences_path" do
     it "returns path" do
       browser.cache_preferences_path.should_not be_empty
     end
   end

   describe "#mac?" do
   end
   
   describe "#linux?" do
    end

   describe "#driver" do
   end
     
   # @private
   # Special method to access the driver
   #attr_reader :driver
   
   describe "#clear_all_private_data" do
     it "clears private data"
   end
   
   describe "#clear_history" do
     it "clears history"
   end
   
   describe "#clear_cache" do
     it "clears cache" 
   end
   
   describe "#close_all_tabs" do
     it "closes all tabs except last" do
       browser.close_all_tabs
       browser.open_pages.should have(1).item
     end
   end
   
   describe "#reset_prefs" do
     it "resets prefs" 
   end
   
   describe "#delete_profile" do
     it "deletes profile"
   end
   
   describe "#set_preference" do
     it "sets preference"
   end

   describe "#get_preference" do
     it "gets preference"
   end
       
   describe "#get_default_preference" do
     it "gets default value of preference"
   end
     
   describe "#start_opera" do
     it "starts opera"
   end

   # Gets the parent widget name of which there is none here
   #describe "#parent_widget" do
   #  it "is nil" do
   #   browser.parent_widget.should be_nil
   #  end
   #end
   
   #describe "#window_id" do
   #  it "is nil" do
   #   browser.window_id.should be_nil
   #  end
   #end
end

