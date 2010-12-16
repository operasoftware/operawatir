module OperaWatir

  # @private
  VERSION = File.read(File.join(File.dirname(__FILE__), '../..', 'VERSION')).strip.freeze

  # Fetches OperaWatir's version number.  Note that this is not the
  # same as OperaDriver's version number.
  #
  # @return [String] current version of OperaWatir
  def self.version
    VERSION
  end
  
end

