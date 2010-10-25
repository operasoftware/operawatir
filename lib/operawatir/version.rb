module OperaWatir

  attr_accessor :driver

  # @private
  VERSION = File.read(File.join(File.dirname(__FILE__), "../..", "VERSION")).strip
  
  # @return [String] current version of OperaWatir
  def self.version
    VERSION
  end
  
  def driver_version
    driver.getOperaDriverVersion
  end

  # TODO
  def platform; end
  def version; end
  def build; end

end
