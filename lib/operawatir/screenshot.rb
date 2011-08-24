class OperaWatir::Screenshot

  attr_accessor :browser, :reply

  def initialize(parent)
    self.browser = parent.browser
    self.reply   = driver.saveScreenshot(2, [].to_java(:string))
  end

  # Saves screenshot to specified location.
  #
  # @param [String]  Path to where you want the screenshot saved.
  # @return [String] The full path to the file that was saved.
  def save(filename)
    File.open(filename, 'w') { |f| f.write png }
    File.expand_path filename
  end

  # Is the screenshot blank?
  #
  # @return [Boolean] True/false depending on the screenshot is blank.
  def blank?
    reply.isBlank
  end

  # Returns the raw byte string of the screenshot in PNG format.
  #
  # @return [String] A png image in a raw byte string.
  def png
    String.from_java_bytes reply.getPng
  end

  # Lets you get a MD5 sum of the screen.
  #
  # @return [String] A hash.
  def md5
    reply.getMd5
  end

private

  def driver
    browser.driver
  end

end
