=begin

OperaHelper -- tool to assist with the writing of test cases and test
  suites using the OperaWatir test framework for the Opera web browser.

Written by Andreas Tolf Tolfsen <andreastt@opera.com>
For internal use only!

=end

require "rubygems"
require "spec"
require "operawatir"
require "inifile"
require "fileutils"
require "pathname"

Spec::Runner.configure do |config|
  config.before(:all) do
    # Fetch configuration.
    @config = IniFile.new("operahelper.ini")

    # If specified browser path is gogilauncher, we first need to
    # retrieve the full directory.
    if @config["browser"]["path"] == "gogi"
      @dir = `gogi -p`.chomp + "/profiles/release_desktop/"
    elsif @config["browser"]["path"].size > 0
      @dir = Pathname.new(@config["browser"]["path"]).parent.realpath.to_s + "/"
    end

    if @dir.size > 0
      # Move opera.ini to safe location (if it exists), and copy in
      # our modified config file.
      FileUtils.mv(@dir + "opera.ini", @dir + "opera.ini.backup") if File.exists?(@dir + "opera.ini")
      FileUtils.cp("lib/opera.ini", @dir + "opera.ini")
    end

    # Base URI.
    @url = "file://localhost/" + Pathname.new(File.dirname(__FILE__) + "/interactive").realpath.to_s + "/"

    # Start a new browser.
    @browser = OperaWatir::Browser.new(@config["browser"]["path"], "-nowindow")
#    @browser = OperaWatir::Browser.new("/home/andreastt/gogilauncher/builds/opera-ppp-mainline-build_4340-buildsetid_23582-core_2_6-lingogi/profiles/release_desktop/lingogi_release_desktop", "-nowindow")
  end

  config.after(:all) do
    # Replace inserted opera.ini file with the user's original.
    FileUtils.mv(@dir + "opera.ini.backup", @dir + "opera.ini") if File.exists?(@dir + "opera.ini.backup")

    # Quit the browser.
    @browser.quit if @browser
  end

  config.before(:each) do
    unless @browser.is_connected?
      @browser = OperaWatir::Browser.new(@config["browser"]["path"], "-nowindow")
      #@browser = OperaWatir::Browser.new
    end
  end

  config.after(:each) {}
end

