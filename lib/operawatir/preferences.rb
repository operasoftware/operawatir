require 'pp'

class String
  def methodize
    self.gsub(/\s+/, '_').downcase
  end
end

class OperaWatir::Preferences
  extend Forwardable
  include Enumerable

  attr_accessor :browser

  # FIXME This should be retrievable from OperaDriver
  SECTIONS = ['Author Display Mode', 'Auto Update', 'BitTorrent',
              'CSS Generic Font Family', 'Cache', 'Clear Private Data Dialog',
              'Colors', 'Developer Tools', 'Disk Cache', 'Extensions',
              'File Selector', 'File Types Section Info', 'Fonts', 'Geolocation',
              'Handheld', 'HotListWindow', 'ISP', 'Install', 'Interface Colors',
              'Java', 'Link', 'Mail', 'MailBox', 'Multimedia', 'Network', 'News',
              'OEM', 'Opera Account', 'Opera Sync', 'Performance', 'Persistent Storage',
              'Personal Info', 'Printer', 'Proxy', 'SVG', 'Saved Settings',
              'Security Prefs', 'Sounds', 'Special', 'Transfer Window',
              'User Agent', 'User Display Mode', 'User Prefs', 'Visited Link',
              'Visited Link', 'Web Server', 'Widgets', 'Workspace']

  def initialize(browser)
    self.browser = browser
    @_prefs = []
  end

  # Section locator
  def method_missing(section)
    # @_prefs[section.to_s] ||= Entry.new self, section
    Entry.new self, section
  end

  def cleanup; end
  def cleanup!; end

  def_delegators :sections, :each,
                            :length,
                            :size,
                            :first,
                            :last,
                            :empty?

  alias_method :each_section, :each

  def to_s
    pp _prefs
  end

  def to_h
    _prefs.dup
  end

private
  def sections
#    @_prefs ||= all_prefs
    all_prefs
  end

  def all_prefs
    list = []
    SECTIONS.each { |s| list << Entry.new(self, s.methodize) }
    list
  end

  def load_from_file(file)
    inifile = Loader.new file
    loaded_prefs = IniFile.new inifile.output.path

    loaded_prefs.each_section do |s|
      s.each do |k,v|
        driver.setPref s,k,v
      end
    end
  end

  def driver
    browser.driver
  end


  class Entry
    extend Forwardable
    include Enumerable

    attr_accessor :parent, :method, :key, :value

    def initialize(parent, method)
      self.parent, self.method, self.key = parent, method, method.to_s.keyize
    end

    def method_missing(key)
      Entry.new self, key
    end

    def value
      return nil if is_section?
      @value ||= driver.getPref parent.key, @key
    end

    def value=(value)
      raise OperaWatir::Exceptions::PreferencesException, 'Sections cannot have values'
      driver.setPref parent.key, @key, value
    end

    def default
      return nil if is_section?
      @default ||= driver.getDefaultPref parent.key, @key
    end

    def default!
      raise OperaWatir::Exceptions::PreferencesException, 'Sections do not have defaults'
      value=(default)
    end

    def each_key
      return unless block_given?
      raw_keys.each { |k| yield k }
    end

    alias_method :each, :each_key

    def is_section?
      @parent.kind_of? OperaWatir::Preferences
    end

  private
    def driver
      @parent.browser.driver || @parent.parent.browser.driver
    end

    def raw_keys
      @_keys ||= all_keys
    end

    def all_keys
      keys = []

      driver.listPrefs(true, @key).to_a.each do |data|
        data = data.to_s

        data =~ /^key: \"([a-zA-Z0-9\(\)\\\.\-\s]*)\"/
        key = $1.gsub(/\\t/, '')

        keys << Entry.new(self, key.methodize)
      end

      keys
    end

  end

end
