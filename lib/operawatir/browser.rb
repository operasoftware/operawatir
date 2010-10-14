class OperaWatir::Browser

  attr_accessor :driver
  
  # HACK For the moment OperaWatir doesn't support multiple windows.
  attr_accessor :active_window

  def initialize(bin_path=nil, *args)
    self.driver = unless bin_path.nil?
      OperaDriver.new(bin_path, *args)
    else
      OperaDriver.new
    end

    self.active_window = OperaWatir::Window.new(self)
  end

  def goto(url)
    active_window.url = url
    active_window
  end
  
  def connected?
    driver.isConnected
  end
  
  def quit
    driver.quit
  end
  
  def close
    driver.close
  end
  
private

  def gc
    driver.gc
  end

  def pid
    driver.getPid
  end

end
