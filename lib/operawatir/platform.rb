require 'rbconfig'

class OperaWatir::Platform
  def self.launcher
    return ENV['OPERA_LAUNCHER'] if ENV['OPERA_LAUNCHER']

    path = case os
    when :windows
      raise Exceptions::NotImplementedException, 'only 32-bit windows supported' if bitsize == 64
      'utils/launchers/launcher-win32-i86pc.exe'
    when :linux
      postfix = bitsize == 64 ? 'x86_64' : 'i686'
      "utils/launchers/launcher-linux-#{postfix}"
    end

    if path
      File.join(root, path)
    else
      raise Exceptions::NotImplementedException, "no known launcher for #{os.inspect}, set OPERA_LAUNCHER to override"
    end

  end

  def self.opera
    ENV['OPERA_PATH']
  end

  def self.args
    ENV['OPERA_ARGS'] || ''
  end

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

  def self.bitsize
    ENV_JAVA['sun.arch.data.model'].to_i
  end

  def self.root
    @root ||= File.expand_path('../../..', __FILE__)
  end
end
