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
  alias_method :url, :url=

  # Query to see if the browser instance is still connected.
  #
  # @return [Boolean] whether driver is still connected to browser
  #   instance.
  def connected?
    driver.isConnected
  end

  # Instruct the browser instance to quit and shut down.
  def quit
    driver.quit
  end

  # TODO: This should be on Windows
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

  # Get the target device's platform.  This is not equivalent of the
  # platform the OperaWatir server might be running on.
  #
  # @return [String] operating system flavour.
  def platform; end

  # Will fetch the build number for the attached browser instance.
  #
  # @return [Integer] build number of attached browser instance.
  def build; end

  # Get the full path to the attached browser binary.
  #
  # @return [String] path to the attached browser's binary.
  def path; end

  # Fetches the user agent (UA) string the browser currently uses.
  #
  # @return [String] user agent string.
  def ua_string; end

  # Is attached browser instance of type internal build or public
  # desktop?
  #
  # @return [Boolean] true if browser attached is of type desktop,
  #                   false otherwise.
  def desktop?
    false
  end

end
