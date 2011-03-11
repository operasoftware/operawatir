# encoding: utf-8
$LOAD_PATH.unshift File.dirname(__FILE__)
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'watirspec_helper'
#require 'operawatir/desktop_helper'

module WatirSpec
  module Helpers
    def browser
      OperaWatir::DesktopHelper.browser
    end
end
end