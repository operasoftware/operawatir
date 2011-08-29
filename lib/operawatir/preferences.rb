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

    raw_prefs = driver.listAllPrefs.to_a
    @_prefs = {}
    @_prefs = raw_prefs.map { |s| Section.new(self, s) }.sort_by { |s| s.key }

    @old_prefs = _prefs
  end

  def_delegators :_prefs, :[],
                          :each,
                          :length,
                          :size,
                          :first,
                          :last,
                          :empty?

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
  # @param           section  method to look up in preferences
  # @return [Object]          a Preferences::Section object
  #

  def method_missing(method)
    method = method.to_s

    if _prefs.any? { |s| s.method == method }
      _prefs.find { |s| s.method == method }
    end
  end

  #
  # Retrieves a human-readable list of Opera preferences available.
  # This is used for convenience and should never be parsed.  Consider
  # using the built-in Ruby iterator #each (with friends) or
  # Preferences#to_a for that.
  #
  # @return [String] list of preferences
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
        text << "    enabled:  #{k.enabled?.inspect}\n"
      end

      text << "\n"
    end

    text
  end

  #
  # Returns a list of all preferences in array form.  This can be used
  # for external parsing.  If you wish to manipulate or iterate through
  # the list of preferences, consider using the built-in Ruby iterator
  # #each (with friends).
  #
  # @return [Array] list of preferences
  #

  def to_a
    _prefs.dup
  end

  #
  # Checks if any preferences exists in your Opera build.  If true,
  # there are preferences available, false otherwise.
  #
  # @return [Boolean] whether any preference exists
  #

  def exists?
    !_prefs.empty?
  end

  alias_method :exist?, :exists?  # LOL Ruby

=begin
  def cleanup
    @old_prefs.dup
  end

  def cleanup!
    @old_prefs.each do |old_section|
      old_section.each do |old_key|
        #self.send(old_section.method).send(old_key.method).send(:value, old_key.value)
        puts "#{old_section.method}.#{old_key.method}.value = #{old_key.value}"
      end
    end

    _prefs
  end
=end

private

  def _prefs
    @_prefs
  end

  #
  # OperaWatir::Preferences::Section represents a section in Opera
  # configuration.
  #

  class Section
    extend Forwardable
    include Enumerable

    attr_accessor :parent, :driver, :method, :key

    def initialize(parent, raw_section)
      self.parent, self.driver = parent, parent.driver
      self.method, self.key    = raw_section.first.methodize, raw_section.first

      @_keys = raw_section[1].map { |k| Key.new(self, k) }.sort_by { |k| k.key }
    end

    def_delegators :_keys, :[],
                           :length,
                           :size,
                           :first,
                           :last,
                           :empty?

    def each
      return unless block_given?
      _keys.each { |k| yield k }
    end

    #
    # When calling Preferences::Section#any_method_name, the
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
    # @param           method  method to look up in section
    # @return [Object]         a Preferences::Section::Key (entry) object
    #

    def method_missing(method)
      method = method.to_s

      if _keys.any? { |k| k.method == method }
        _keys.find { |k| k.method == method }
      end
    end

  private

    def _keys
      @_keys
    end

    class Key
      extend Forwardable
      include Enumerable

      attr_accessor :parent, :driver, :method, :key, :type, :value

      def initialize(parent, raw_key)
        self.parent, self.driver = parent, parent.driver
        self.method, self.key = raw_key.first.methodize, raw_key.first
        raw_data = raw_key[1].to_s

        raw_data =~ /^type: ([A-Z]+)$/
        self.type = $1.to_s.capitalize

        raw_data =~ /^value: \"(.*)\"$/
        @value = $1.to_s

        # Ruby doesn't support attr_accessor's with question mark in their
        # name.
        raw_data =~ /^enabled: (true|false)$/
        @enabled = $1.truthy?
      end

      #
      # Whether the current key entry is enabled inside Opera or not.
      #
      # @return [Boolean] true if enabled, false if otherwise
      #

      def enabled?
        !!@enabled
      end

      #
      # Sets the key's value to the specified string.
      #
      # @param [String] value  the value you wish to set for the key
      #

      def value=(value)
        value = value.truthy? ? '1' : '0' if type.include?('Boolean')
        driver.setPref parent.key, key, value.to_s
        @value = value
      end

      #
      # Returns key's default value.
      #
      # @return [String] the default value of the key
      #

      def default
        @default ||= driver.getDefaultPref parent.key, key
      end

      #
      # Returns and sets the default value of the key.
      #
      # @return [String] the default value of the key
      #

      def default!
        self.value=(default)
      end
    end
  end

end
