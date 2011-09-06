# -*- coding: utf-8 -*-
class OperaWatir::Browser
  include Deprecated

  attr_accessor :driver, :active_window, :preferences, :keys, :spatnav

  def self.settings=(settings={})
    @desired_capabilities = nil  # Bust cache
    @settings = settings
  end

  def self.settings
    @settings || self.settings = {}
  end

  # Constructs a new OperaDriver::Browser object.
  #
  # @example
  #   browser = OperaWatir::Browser.new
  #
  # @return [Object] OperaWatir::Browser class.
  def initialize
    OperaWatir.compatibility! unless OperaWatir.api >= 3

    self.driver        = OperaDriver.new(self.class.desired_capabilities)
    self.active_window = OperaWatir::Window.new(self)
    self.preferences   = OperaWatir::Preferences.new(self)
    self.keys          = OperaWatir::Keys.new(self)
    self.spatnav       = OperaWatir::Spatnav.new(self)
  end

  alias_method :window, :active_window

  # Get the name of the browser currently being run.
  #
  # @return [String] Name of browser currently used.
  def name
    'Opera'
  end

  # Navigate to a new URL and return a Window object.
  #
  # @param  [String] url The URL you wish to go to.
  # @return [Object] A Window object.
  def url=(url)
    active_window.url = url
  end

  # Instruct the browser instance to quit and shut down.
  def quit
    driver.shutdown
  end

  # Get the version number of the driver.  This _is not_ the same as
  # the version number for OperaWatir, which can be retrieved using
  # +OperaWatir.version+ instead.
  #
  # @return [String] Driver version.
  def version
    driver.getVersion
  end

  # Get the target device's platform.  This is not equivalent of the
  # platform the OperaWatir server might be running on.
  #
  # @return [String] Operating system flavour of the device we're
  #   testing on.
  def platform
    window.execute_script('navigator.platform')
  end

  # Get the full path to the attached browser binary.
  #
  # @return [String] Path to the attached browser's binary.
  def path
    driver.getPath
  end

  # Fetches the user agent (UA) string the browser currently uses.
  #
  # @return [String] User agent string.
  def ua_string
    window.execute_script('navigator.userAgent')
  end

  # Is attached browser instance of type internal build or public
  # desktop?
  #
  # @return [Boolean] True if browser attached is of type desktop,
  #   false otherwise.
  def desktop?
    false  # FIXME
  end

  # Sends an Opera action to the browser.
  #
  # @param  [String] Name of the action.
  # @return [String] Optional return from the performed action.
  def opera_action(name, *args)
    driver.operaAction(name, args.to_java(:string))
  end
  deprecated :opera_action

  # Full list of available Opera actions in the Opera build you're
  # using.  Note that this list varies from configuration to
  # configuration, and from build to build.  The Opera actions
  # available to devices-type builds will vary greatly from those
  # available to desktop-types.
  #
  # @return [String] List of available Opera actions.
  def opera_action_list
    driver.getOperaActionList.to_a
  end
  deprecated :opera_action_list

  # Selects all content in the currently focused element.  Equivalent
  # to pressing C-a in a desktop browser.  To select content in a
  # <textarea> or an <input> field, remember to click it first.
  def select_all
    # FIXME
    driver.operaAction('Select all')
  end

  # Copies the currently selected content to the clipboard.
  # Equivalent to pressing C-c in a desktop browser.
  def copy

    # FIXME: #copy, #cut and #paste really shouldn't use platform-
    # dependent keypresses like this.  But until DSK-327491 is fixed,
    # this will have to do.
    if OperaWatir::Platform.os == :macosx
      keys.send [:command, 'c']
    else
      keys.send [:control, 'c']
    end
  end

  # Cuts the currently selected content to the clipboard.  Equivalent
  # to pressing C-x in a desktop browser.
  def cut

    # FIXME
    if OperaWatir::Platform.os == :macosx
      keys.send [:command, 'x']
    else
      keys.send [:control, 'x']
    end
  end

  # Pastes content from the clipboard into the currently focused
  # element.  Equivalent to pressing C-v in a desktop browser.  To
  # paste content into textarea or input fields, remember to click it
  # first.
  def paste

    # FIXME
    if OperaWatir::Platform.os == :macosx
      keys.send [:command, 'v']
    else
      keys.send [:control, 'v']
    end
  end


  # Keyboard

  def key(key)
    driver.key(key)
  end

  deprecated :key, 'browser.keys.send'

  def key_down(key)
    driver.keyDown(key)
  end

  deprecated :key, 'browser.keys.down'

  def key_up(key)
    driver.keyUp(key)
  end

  deprecated :key, 'browser.keys.up or browser.keys.release'

  def type(text)
    driver.type(text)
  end

  deprecated :key, 'browser.keys.send'

  # actions

  def actions
    OperaWatir::Actions.new(browser)
  end

private

  def self.desired_capabilities
    @desired_capabilities ||= DesiredCapabilities.new.tap { |s|
      s.setCapability('opera.autostart', false) if self.settings[:manual]
      s.setCapability('opera.launcher', self.settings[:launcher]) if self.settings[:launcher]
      s.setCapability('opera.binary', self.settings[:path]) if self.settings[:path]
      s.setCapability('opera.arguments', self.settings[:args].to_s) if self.settings[:args]
      s.setCapability('opera.no_quit', true) if self.settings[:no_quit]
      s.setCapability('opera.idle', true) if self.settings[:opera_idle] or ENV['OPERA_IDLE'].truthy?
    }
  end

end
