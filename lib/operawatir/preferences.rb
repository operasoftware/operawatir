require 'pp'

class String
  def methodize
    self.gsub(/\s+/, '_').downcase
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

=begin
  new_sections = {}

  SECTIONS.each_with_index do |s,i|
    new_sections[s] = s.methodize
  end

  SECTIONS = new_sections
  pp SECTIONS
  abort
=end

  def initialize(browser)
    self.browser, self.driver = browser, browser.driver

    @_prefs = []

    SECTIONS.each do |s|
      _prefs << Entry.new(self, s.methodize, s)
    end
  end

  def method_missing(section)
    if _prefs.any? { |s| s.method == section }
      _prefs.find { |s| s.method == section }
    else
      _prefs << Entry.new(self, section)
      _prefs.last
    end
  end

  def_delegators :_sections, :each

  alias_method :each_section, :each

private

  def _prefs
    @_prefs ||= []
  end

  def _sections
=begin
    if @_prefs.size != SECTIONS.size
      _prefs = []
      SECTIONS.each do |s|
#        puts "#{s} => #{s.methodize} => #{s.methodize.keyize}"
        puts "#{s} => #{s[0]}"
        _prefs << Entry.new(self, s[0])# s.methodize)
      end
    end
=end

    _prefs
  end


  class Entry
    extend Forwardable
    include Enumerable

    attr_accessor :parent, :method, :key, :value, :driver

    def initialize(parent, method, key='')
      self.parent, self.method, self.key, self.driver = parent, method, (key ? key : method.to_s.keyize), parent.driver
      puts "Preferences::Entry#new (#{method} => #{key})"
      raise OperaWatir::Exceptions::PreferencesException, 'No such preference' unless exists?
    end

    def method_missing(key)
      puts "Preferences::Entry#method_missing (#{key})"

      if _keys.any? { |k| k.method == key }
        _keys.find { |k| k.method == key }
      else
        _keys << Entry.new(self, key)
        _keys.last
      end
    end

    def value
      @value ||= section? ? key : driver.getPref(parent.key, key)
    end

    def section?
      parent.kind_of? OperaWatir::Preferences
    end

    def exists?
      section? ? SECTIONS.include?(key) : !key.empty? # !value.empty?
    end

    alias_method :exist?, :exists?  # LOL Ruby

#    def_delegators :_keys, :each
    def each
      puts 'Preferences::Entry#each'
      _keys = all_keys
    end

    alias_method :each_key, :each

  private

    def _keys
      @_keys ||= []
    end

    def all_keys
      return if not section?
      puts "Preferences::Entry#all_keys (key: #{key})"

      keys = []

      driver.listPrefs(true, key).to_a.each do |data|
        data = data.to_s

        data =~ /^key: \"([a-zA-Z0-9\(\)\\\.\-\s]*)\"/
        new_key = $1.gsub(/\\t/, '')

        puts "new key: #{new_key}"

        keys << Entry.new(self, new_key.methodize, new_key)
      end

      keys
    end

  end

end
