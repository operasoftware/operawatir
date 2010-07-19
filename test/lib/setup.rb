$SETUP_LOADED = true

$myDir = File.expand_path(File.dirname(__FILE__))

# Use local development versions of Watir, FireWatir, SafariWatir, commonwatir,
# OperaWatir if available.
topdir = File.join(File.dirname(__FILE__), "..")
$firewatir_dev_lib = File.join(topdir, "..", "firewatir", "lib")
$opera_dev_lib = File.join(topdir, "..", "operawatir", "lib")
$watir_dev_lib = File.join(topdir, "..", "watir", "lib")
$LOAD_PATH.unshift File.expand_path(File.join(topdir, "lib"))

puts $LOAD_PATH

require "watir/browser"
Watir::Browser.default = "opera"
require "unittests/setup/lib"

Dir.chdir topdir do
  $all_tests = Dir["unittests/*.rb"]
end

