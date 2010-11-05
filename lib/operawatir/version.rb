module OperaWatir
class OperaWatir

  # @private
  VERSION = "0.2.10".freeze
  
  # @return [String] current version of OperaWatir
  def self.version
    VERSION
  end
  
  def self.driver_version
    driver.getOperaDriverVersion
  end
  
  # TODO
  def self.platform; end
  def self.version; end
  def self.build; end

end
end
