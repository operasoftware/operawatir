module OperaWatir

  # @private
  VERSION = File.read(File.join(File.dirname(__FILE__), '../..', 'VERSION')).strip.freeze

  # @return [String] current version of OperaWatir
  def self.version
    VERSION
  end
  
end

