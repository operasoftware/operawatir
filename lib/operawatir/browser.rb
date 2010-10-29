class OperaWatir::Browser

  attr_accessor :driver
  attr_accessor :active_window

  def initialize(bin_path=nil, *args)
    self.driver = if bin_path
      OperaDriver.new(bin_path, args.to_java(:string))
    else
      OperaDriver.new
    end

    self.active_window = OperaWatir::Window.new(self)
  end
  
  # Get the name of the browser currently being run.
  #
  # @return [String] name of browser currently used.
  def name
    'Opera'
  end

  def url=(url)
    active_window.url = url
    active_window
  end
  alias_method :goto, :url=  # deprecate?
  
  # Query to see if the browser instance is still connected.
  #
  # @return [Boolean] whether driver is still connected to browser
  #   instance.
  def connected?
    driver.isConnected
  end
  
  # Tell the browser instance to quit and shut down. 
  def quit
    driver.quit
  end
  
  # FIXME: Obsolete?
  def close_all
    driver.closeAll
  end

  # Get the version number of the driver.  This _is not_ the same as
  # the version number for OperaWatir, which can be retrieved using
  # +OperaWatir.version+ instead.
  #
  # @seealso OperaWatir.version
  # @return [String] driver version.
  def version
    driver.getOperaDriverVersion
  end

  # Get process identifier for spawned Opera browser instance.  This
  # will only work if instance was started through OperaWatir.
  #
  # @return [Integer] the process ID of the browser instance.
  def pid
    driver.getPid
  end

end
