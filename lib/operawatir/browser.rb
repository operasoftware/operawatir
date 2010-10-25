class OperaWatir::Browser

  attr_accessor :driver
  
  # FIXME: HACK For the moment OperaWatir doesn't support multiple windows.
  attr_accessor :active_window

  def initialize(bin_path=nil, *args)
    self.driver = if bin_path
      OperaDriver.new(bin_path, args.to_java(:string))
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
  
  def close_all
    driver.closeAll
  end

  def driver_version
    driver.getOperaDriverVersion
  end

  # TODO
  def platform; end
  def version; end
  def build; end

end
