module OperaWatir
  class Browser
    include Container
    def initialize (executable_location = nil, *arguments)
      if executable_location.nil?
        @driver = OperaDriver.new
        @frame = '_top'
      else
        @driver = OperaDriver.new(executable_location, arguments.to_java(:String))
      end
    end

    def goto(url = "")
      raise 'You need to specify an address' if url.empty?
      @driver.get(url)
    end

    def stop
      @driver.stop
    end

    def clean_up
      @driver.cleanUp
    end

    def driver
      return @driver
    end

    def title
      return @driver.getTitle
    end

    def close
      @driver.close
    end

    def text
      return @driver.getText
    end

    def back
      return @driver.navigate.back
    end

    def forward
      return @driver.navigate.forward
    end

    def refresh
      return @driver.navigate.refresh
    end

    def frame(how, what)
      case how
      when :name
        @driver.switchTo.frame(what)
      when :index
        @driver.switchTo.frame(what.to_i - 1) #index starts from 1 in watir
      end
      return self
    end

    def show_frames
      frames = @driver.listFrames
      puts "There are #{frames.length.to_s} frames"
      frames.each_with_index { |frame,i|
        puts "frame index:#{(i.to_i+1).to_s} name:#{frame.to_s}"
      }
    end

    def close_all
      return @driver.quit
    end
    alias_method :quit, :close_all

    def execute_script(source)
      return @driver.executeScript(source, [].to_java(:String))
    end
    
    def key(key)
      @driver.key(key)
    end

    def key_down(key)
      @driver.keyDown(key)
    end

    def key_up(key)
      @driver.keyUp(key)
    end

    def type(text)
      @driver.type(text)
    end

    def url
      return @driver.getCurrentUrl
    end

    def opera_action(name, *param)
      @driver.operaAction(name, param.to_java(:String))
    end

    def take_screenshot(file_name,hashes,time_out)
      @driver.saveScreenshot(file_name, time_out, hashes.to_java(:String))
    end

    def get_hash(time_out = 50)
      @driver.findElementByTagName('body').getImageHash
    end

    def opera_action_list
      @driver.getOperaActionList
    end

    def open_tabs
      @driver.getWindowHandles.size
    end

    def gc
      @driver.gc
    end

    def is_connected?
      @driver.isConnected
    end

     def pid
      @driver.getPid
    end

  end
end