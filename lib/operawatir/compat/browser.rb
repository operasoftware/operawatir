module OperaWatir
  module Compat
    module Browser
      extend Forwardable

      def method_missing(method, *args, &blk)
        if active_window.respond_to? method
          active_window.send(method, *args, &blk)
        else
          super
        end
      end

      # Class#type is defined by Ruby, it will never reach
      # #method_missing.
      def_delegator :active_window, :type

    end
  end
end
