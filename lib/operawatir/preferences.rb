# -*- coding: utf-8 -*-
class String

  #
  # Translates an Opera preferences key string into a Ruby method name.
  # It will remove tabs and spaces at beginning of string, replace
  # further spaces with an underscore and make the string lower-case.
  #
  # The method extends the String object and can be called as a regular
  # method on any string in Ruby.
  #

  def methodize
    self.gsub(/^\\t(\s+)/, '').gsub(/\s+/, '_').downcase
  end

  #
  # Translates a previously keyized Opera preferences method string into
  # an Opera preferences key string.  This is done by replacing
  # underscores with spaces and capitalizing each word in the string.
  #
  # The method extends the String object and can be called as a regular
  # method on any string in Ruby.
  #

  def keyize
    self.gsub(/_/, ' ').gsub(/\b('?[a-z])/) { $1.capitalize }
  end
end

#
# OperaWatir::Preferences enables you to access the browser preferences
# in the Opera web browser.
#
# @example
#
#   The Preferences object is created automatically when creating a new
#   Browser object and is exposed as an interface on that object:
#
#     browser.preferences
#     => <OperaWatir::Preferences>
#
#   You can interact with this object as you would with any Ruby object.
#   Sections and entries are exposed as Rubyized method names, which
#   means that you can access them like this:
#
#     browser.preferences.interface_colors             # a section
#     browser.preferences.interface_colors.background  # an entry
#
#   Over the preference object itself or over a section you can also use
#   built-in Ruby convenience methods such as:
#
#     browser.preferences.first             # first section
#     browser.preferences.interface_colors  # first entry in section
#     browser.preferences.size              # number of sections
#
#   This is a full list of available convenience methods:
#
#     * []
#     * each
#     * length
#     * size
#     * first
#     * last
#     * empty?
#
#   Essentially, the preference and section objects are collections
#   (kind of like arrays) that allows you to also iterate over them:
#
#     browser.preferences.each_with_index do |section, index|
#       puts "Section No. #{index} is called `#{section.key}'"
#     end
#
#     browser.preferences.interface_colors.each { |e| e.value = '#cccccc' }
#
#     browser.preferences.interface_colors[5].value
#     => '#cccccc'
#
#   On each section, the follow getters are available in addition to the
#   convenience methods mentioned above:
#
#     * section?  # Returns true/false based on whether it's a section
#     * exists?   # Returns true/false based on whether it exists
#
#   On each entry, the following getters and setters are available in
#   addition to the convenience methods mentioned above:
#
#     * value     # Returns current preference's value
#     * value=    # Sets current preference's value to provided string
#     * default   # Returns current preference's default
#     * default!  # Sets current preference to its default
#
#   This means you can do crazy stuff like resetting all the preferences
#   in `opera:config` to their standard value like this:
#
#     browser.preferences.each do |section|
#       section.each do |entry|
#         entry.default!
#       end
#     end
#

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

  #
  # The OperaWatir::Preferences object is created automatically when you
  # create an OperaWatir::Browser object, and is available as
  # Browser#prefrences.
  #
  # @example
  #
  #   browser.preferences.method_name
  #
  # @param [Object] browser  An OperaWatir::Browser object.
  #

  def initialize(browser)
    self.browser, self.driver = browser, browser.driver
  end

  #
  # When calling Preferences#any_method_name, the `any_method_name` will
  # be caught by this method.
  #
  # This is the standard way of looking up sections.  `any_method_name`
  # should be replaced by a methodized version of the section as it
  # appears in the Opera preferences list which you can find at
  # `opera:config`.
  #
  # @example
  #
  #   browser.preferences.interface_colors
  #   # will return section “Interface Colors”
  #
  # @param           section  Method to look up in preferences.
  # @return [Object]          A Preferences::Entry (section) object.
  #

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

  #
  # Retrieves a human-readable list of Opera preferences available.
  # This is used for convenience and should never be parsed.  Consider
  # using the built-in Ruby iterator #each (with friends) or
  # Preferences#to_a for that.
  #
  # @return [String]          List of preferences.
  #

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

  #
  # Returns a list of all preferences in array form.  This can be used
  # for external parsing.  If you wish to manipulate or iterate through
  # the list of preferences consider using the built-in Ruby iterator
  # #each (with friends).
  #
  # @return [Array]           List of preferences.
  #

  def to_a
    _prefs.dup
  end

  #
  # Checks if any preferences exists in your Opera build.  If true,
  # there are preferences available, false otherwise.
  #
  # @return [Boolean]         Whether any preferences exists.
  #

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

    #
    # OperaWatir::Preferences::Entry is the object that represents
    # either a section or a section's entry.
    #
    # It's created automatically when you query for entries using the
    # Preference object itself.
    #
    # @return [Object] An OperaWatir::Preferences::Entry object.
    #

    def initialize(parent, method, key=nil, type=nil)
      self.parent = parent
      self.method = method.to_s
      self.key    = key ? key : method.to_s.keyize
      self.type   = type
      self.driver = parent.driver
    end

    #
    # When calling Preferences::Entry#any_method_name, the
    # `any_method_name` will be caught by this method.
    #
    # This is the standard way of looking up preference entries.
    # `any_method_name` should be replaced by a methodized version of
    # the entry as it appears in the Opera preferences list which you
    # can find at `opera:config`.
    #
    # @example
    #
    #   browser.preferences.interface_colors.background
    #   # will return the “Background” entry in section “Interface Colors”
    #
    # @param           method  Method to look up in section.
    # @return [Object]         A Preferences::Entry (entry) object.
    #

    def method_missing(method)
      method = method.to_s
      
      if _keys.any? { |k| k.method == method }
        _keys.find { |k| k.method == method }
      else
        _keys << Entry.new(self, method)
        _keys.last
      end
    end

    #
    # Returns the value of an entry in a section.  Note that it's not
    # possible to retrieve the value for sections.
    #
    # @return [String] Value of the entry.
    #

    def value
      raise OperaWatir::Exceptions::PreferencesException, 'Sections do not have values' if section?
      @value ||= driver.getPref(parent.key, key)
    end

    #
    # Sets the entry's value to the specified string.  Note that it's
    # not possible to set a section's value.
    #
    # @param [String] value  Value you wish to set for the entry.
    #

    def value=(value)
      raise OperaWatir::Exceptions::PreferencesException, 'Sections cannot have values' if section?
      value = value.truthy? ? '1' : '0' if type.include?('Boolean')
      driver.setPref parent.key, key, value.to_s
      @value = value
    end

    #
    # Returns entry's default value.  Note that it's not possible to
    # return a section's default value.
    #
    # @return [String]       The default value of the entry.
    #

    def default
      raise OperaWatir::Exceptions::PreferencesException, 'Sections do not have defaults' if section?
      @default ||= driver.getDefaultPref parent.key, key
    end

    #
    # Returns and sets the default value of the entry.  Note that it's
    # not possible to return and set a section's default value.
    #
    # @return [String]       The default value of the entry.
    #

    def default!
      self.value=(default)  # WTF?  Bug in Ruby?
    end

    #
    # Is the current node a section?
    #
    # @return [Boolean]      True/false based on whether you're
    #                        interacting with a section or entry.
    #

    def section?
      parent.kind_of? OperaWatir::Preferences
    end

    #
    # Does this entry/section exist?
    #
    # @return [Boolean]      True/false based on whether the method you
    #                        are attempting to access exists as a
    #                        preference entry/section.
    #

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

      driver.listPrefs(true, key).to_a.each do |p|
        p = p.to_s
        
        p =~ /^key: \"([a-zA-Z0-9\(\)\\\.\-\s]*)\"$/
        key = $1.to_s.gsub(/^\\t/, "\t")  # Workaround for double-encoded tabs:
                                          # We get \\t, but it only accepts \t.
        
        p =~ /^type: ([A-Z]+)$/
        type = $1.to_s.capitalize

        next if key.empty?  # “Opera Widgets/Unite Style File” is bugged, workaround.
        keys << Entry.new(self, key.methodize, key.gsub(/^\\t/, "\t"), type)
      end

      keys
    end

  end

end
