# -*- coding: utf-8 -*-
class OperaWatir::Browser

  attr_accessor :driver, :active_window

  def self.settings=(settings={})
    @opera_driver_settings = nil  # Bust cache
    @settings = settings.merge! :launcher => OperaWatir::Platform.launcher,
                                :path     => OperaWatir::Platform.opera,
                                :args     => OperaWatir::Platform.args
  end

  def self.settings
    @settings || self.settings = {}
  end

  def initialize
    OperaWatir.compatibility! unless OperaWatir.api >= 2

    self.driver = OperaDriver.new(self.class.opera_driver_settings)
    self.active_window = OperaWatir::Window.new(self)
  end

  # Get the name of the browser currently being run.
  #
  # @return [String] name of browser currently used
  def name
    'Opera'
  end

  def url=(url)
    active_window.url = url
  end
  alias_method :url, :url=

  # Tells you whether the browser object exists.  Note that this is
  # not the same as checking whether the object is connected to a
  # browser.
  #
  # @return [Boolean] whether Browser object exists
  def exists?
    true
  end

  # Query to see if the browser instance is still connected.
  #
  # @return [Boolean] whether driver is still connected to browser
  #   instance
  def connected?
    driver.isConnected
  end

  # Instruct the browser instance to quit and shut down.
  def quit!
    driver.shutdown
  end

  # Closes all windows.
  #
  # TODO This should be on Windows
  def close_all
    driver.closeAll
  end

  # Accesses the keys API in OperaWatir::Keys.
  def keys
    OperaWatir::Keys.new(self)
  end

  # Set preference pref in prefs section prefs_section to value
  # specified.
  #
  # TODO: This needs to be moved to a separate preference section.
  #
  # @param [String] prefs_section The prefs section the pref belongs to
  # @param [String] pref          The preference to set
  # @param [String] value         The value to set the preference to
  def set_preference(prefs_section, pref, value)
    @driver.setPref(prefs_section, pref, value.to_s)
  end
      
  # Get value of preference pref in prefs section prefs_section.
  #
  # TODO: This needs to be moved to a separate preference section.
  #
  # @param [String] prefs_section The prefs section the pref belongs to
  # @param [String] pref          The preference to get
  #
  # @return [String] The value of the preference
  def get_preference(prefs_section, pref)
    @driver.getPref(prefs_section, pref)
  end
    
  # Get default value of preference pref in prefs section
  # prefs_section.
  #
  # TODO: This needs to be moved to a separate preference section.
  #
  # @param [String] prefs_section The prefs section the pref belongs to
  # @param [String] pref          The preference to get
  #
  # @return [String] The value of the preference
  def get_default_preference(prefs_section, pref)
    @driver.getDefaultPref(prefs_section, pref)
  end

  # Get the version number of the driver.  This _is not_ the same as
  # the version number for OperaWatir, which can be retrieved using
  # +OperaWatir.version+ instead.
  #
  # @return [String] driver version
  def version
    driver.getOperaDriverVersion
  end

  # Get process identifier for spawned Opera browser instance.  This
  # will only work if instance was started through OperaWatir.
  #
  # @return [Integer] the process ID of the browser instance
  def pid
    driver.getPid
  end

  # Get the target device's platform.  This is not equivalent of the
  # platform the OperaWatir server might be running on.
  #
  # @return [String] operating system flavour
  def platform
    driver.getPlatform
  end

  # Will fetch the build number for the attached browser instance.
  #
  # @return [Integer] build number of attached browser instance
  def build
    driver.getBuild
  end

  # Get the full path to the attached browser binary.
  #
  # @return [String] path to the attached browser's binary
  def path
    driver.getPath
  end

  # Fetches the user agent (UA) string the browser currently uses.
  #
  # @return [String] user agent string
  def ua_string
    driver.getUaString
  end

  # Is attached browser instance of type internal build or public
  # desktop?
  #
  # @return [Boolean] true if browser attached is of type desktop,
  #   false otherwise
  def desktop?
    false  # FIXME
  end

  # Sends an Opera action to the browser.
  #
  # @param [String] name of the action
  # @return [String] optional return from the performed action
  def opera_action(name, *args)
    @driver.operaAction(name, param.to_java(:string))
  end

  # Full list of available Opera actions in the Opera build you're
  # using.  Note that this list varies from configuration to
  # configuration, and from build to build.  The Opera actions
  # available to devices-type builds will vary greatly from those
  # available to desktop-types.
  #
  # @return [String] list of available Opera actions
  def opera_action_list
    @driver.getOperaActionList
  end

private

  def self.opera_driver_settings
    @opera_driver_settings ||= OperaDriverSettings.new.tap {|s|
      s.setRunOperaLauncherFromOperaDriver true
      s.setOperaLauncherBinary self.settings[:launcher]
      s.setOperaBinaryLocation self.settings[:path]
      s.setOperaBinaryArguments self.settings[:args] + ' -watirtest'
    }
  end

end
