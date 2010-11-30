require 'ostruct'

class Object
  def truth?
    self && [true, 'true', 'yes', 'y', '1', 1].include?(self)
  end
end

module OperaWatir

  class Settings
    def initialize(*args, &block)
      SettingsHelper.block_to_hash(block).each do |setting, value|
        self.class.send(:define_method, setting.to_sym) do
          value || instance_variable_get("@#{attr}")
        end
      end
    end
  end

  class SettingsHelper < OpenStruct
    def self.block_to_hash(block=nil)
      config = self.new

      if block
        block.call(confi)
        config.to_hash
      else
        {}
      end
    end

    def to_hash
      @table
    end
  end

end
