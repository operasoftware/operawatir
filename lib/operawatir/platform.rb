require 'rbconfig'

class OperaWatir::Platform
  def self.os
    @os ||= (
      host_os = RbConfig::CONFIG['host_os']
      case host_os
      when /mswin|msys|mingw|bccwin|wince|emc/
        :windows
      when /darwin|mac os/
        :macosx
      when /linux/
        :linux
      when /solaris|bsd/
        :unix
      else
        raise Exceptions::NotImplementedException, "#{host_os.inspect} not supported"
      end
    )
  end
end
