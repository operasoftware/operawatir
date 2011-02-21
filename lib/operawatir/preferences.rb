class String
  def methodize
    self.gsub(/^\\t(\s+)/, '').gsub(/\s+/, '_').downcase
  end

  def keyize
    self.gsub(/_/, ' ').gsub(/\b('?[a-z])/) { $1.capitalize }
  end
end

class Object
  def truthy?
    self && [true, 'true', 'yes', 'y', '1', 1].include?(self)
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
        text << "    type:     #{k.type.inspect}\n"
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

    attr_accessor :parent, :method, :key, :value, :type, :default, :driver

    def initialize(parent, method, key=nil, type=nil)
      self.parent = parent
      self.method = method.to_s
      self.key    = key ? key : method.to_s.keyize
      self.type   = type
      self.driver = parent.driver
    end

    def method_missing(key)
      key = key.to_s
      
      if _keys.any? { |k| k.method == key }
        _keys.find { |k| k.method == key }
      else
        _keys << Entry.new(self, key)
        _keys.last
      end
    end

    def value
      raise OperaWatir::Exceptions::PreferencesException, 'Sections do not have values' if section?
      @value ||= driver.getPref(parent.key, key)
    end

    def value=(value)
      raise OperaWatir::Exceptions::PreferencesException, 'Sections cannot have values' if section?
      value = value.truthy? ? '1' : '0' if type.include?('Boolean')
      driver.setPref parent.key, key, value.to_s
      @value = value
    end

    def default
      raise OperaWatir::Exceptions::PreferencesException, 'Sections do not have defaults' if section?
      @default ||= driver.getDefaultPref parent.key, key
    end

    def default!
      self.value=(default)  # WTF?  Bug in Ruby?
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
      raise OperaWatir::Exceptions::PreferencesException, 'Keys are not iteratable objects' if not section?
      @_keys ||= all_keys
    end

    def all_keys
      return if not section?
      keys = []

      driver.listPrefs(true, key.to_s).to_a.each do |data|
        data = data.to_s
        
        data =~ /^key: \"([a-zA-Z0-9\(\)\\\.\-\s]*)\"$/
        new_key = $1
        
        data =~ /^type: ([A-Z]+)$/
        type = $1.to_s.capitalize

        keys << Entry.new(self, new_key.methodize, new_key.gsub(/^\\t/, "\t"), type)
      end

      keys
    end

  end

end
