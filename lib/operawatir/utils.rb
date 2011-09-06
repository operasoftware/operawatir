class OperaWatir::Utils

  def initialize(browser)
    @utils = browser.driver.utils
  end

  def core_version
    @utils.getCoreVersion
  end

  def os
    @utils.getOS
  end

  def product
    @utils.getProduct
  end

  def binary_path
    @utils.getBinaryPath
  end

  def user_agent
    @utils.getUserAgent
  end

  def pid
    @utils.getPID
  end

end
