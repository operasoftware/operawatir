# require 'ostruct'
# 
# 
# 
# module OperaWatir
#   class Settings
# 
#     attr_accessor :driver_settings
# 
#     def initialize(&block)
#       SettingsHelper.block_to_hash(block).each do |setting, value|
#         self.class.send(:define_method, setting.to_sym) do
#           value.to_s || instance_variable_get("@#{attr}")
#         end
#       end
# 
#       self.driver_settings = OperaDriverSettings.new
# 
#       driver_settings.setRunOperaLauncherFromOperaDriver true
#       driver_settings.setOperaLauncherBinary launcher
#       driver_settings.setOperaBinaryLocation path
#       driver_settings.setOperaBinaryArguments args
#     end
#   end
# 
#   class SettingsHelper < OpenStruct
#     def self.block_to_hash(block=nil)
#       config = self.new
# 
#       if block
#         block.call(config)
#         config.to_hash
#       else
#         {}
#       end
#     end
# 
#     def to_hash
#       @table
#     end
#   end
# 
# end
