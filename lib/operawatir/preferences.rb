class String
  def methodize
    self.gsub(/^\\t(\s+)/, '').gsub(/\s+/, '_').downcase
  end

  def keyize
    self.gsub(/_/, ' ').gsub(/\b('?[a-z])/) { $1.capitalize }
  end
end


class OperaWatir::Preferences
  extend Forwardable
  include Enumerable

  attr_accessor :browser, :driver

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
    self.browser, self.driver = browser, browser.driver
  end

  def method_missing(section)
    if _prefs.any? { |s| s.method == section.to_s }
      _prefs.find { |s| s.method == section.to_s }
    else
      _prefs << Entry.new(self, section)
      _prefs.last
    end
  end

  def_delegators :_prefs, :[],
                          :each,
                          :length,
                          :size,
                          :first,
                          :last,
                          :empty?

  def to_s
    text = ''

    _prefs.each do |s|
      text << "#{s.method}\n"

      s.each do |k|
        text << "  #{k.method}\n"
        text << "    value:    #{k.value.inspect}\n"
        text << "    default:  #{k.default.inspect}\n"
      end
    end

    text
  end

  def to_a
    _prefs.dup
  end

  def exists?
    !_prefs.empty?
  end
  
  alias_method :exist?, :exists?  # LOL Ruby

private

  def _prefs
    @_prefs ||= SECTIONS.map { |s| Entry.new(self, s.methodize, s) }
  end


  class Entry
    extend Forwardable
    include Enumerable

    attr_accessor :parent, :method, :key, :value, :default, :driver

    def initialize(parent, method, key=nil)
      self.parent = parent
      self.method = method
      self.key    = key ? key : method.to_s.keyize
      self.driver = parent.driver
    end

    def method_missing(key)
      if _keys.any? { |k| k.method == key }
        _keys.find { |k| k.method == key }
      else
        _keys << Entry.new(self, key)
        _keys.last
      end
    end

    def type
      raise OperaWatir::Exceptions::NotImplementedException
    end

    def value
      raise OperaWatir::Exceptions::PreferencesException, 'Sections do not have values' if section?
      @value ||=  driver.getPref(parent.key, key)
    end

    def value=(value)
      raise OperaWatir::Exceptions::PreferencesException, 'Sections cannot have values' if section?
      driver.setPref parent.key, key, value
      @value = value
    end

    def default
      raise OperaWatir::Exceptions::PreferencesException, 'Sections do not have defaults' if section?
      @default ||= driver.getDefaultPref parent.key, key
    end

    def default!
      value=(default)
    end

    def section?
      parent.kind_of? OperaWatir::Preferences
    end

    def exists?
      section? ? SECTIONS.include?(key) : !type.empty?
    end

    alias_method :exist?, :exists?  # LOL Ruby

    def each
      return unless block_given?
      _keys.each { |k| yield k }
    end

    def_delegators :_keys, :[],
                           :length,
                           :size,
                           :first,
                           :last,
                           :empty?

  private

    def _keys
      @_keys ||= all_keys
    end

    def all_keys
      return if not section?
      keys = []

      driver.listPrefs(true, key.to_s).to_a.each do |data|
        data = data.to_s

        data =~ /^key: \"([a-zA-Z0-9\(\)\\\.\-\s]*)\"/
        new_key = $1

        keys << Entry.new(self, new_key.methodize, new_key.gsub(/^\\t/, "\t"))
      end

      keys
    end

  end

end
