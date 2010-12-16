module OperaWatir
  module Compat
    module Browser

      def method_missing(method, *args, &blk)
        if active_window.respond_to? method
          active_window.send(method, *args, &blk)
        else
          super
        end
      end

      def quit
        quit!
      end

    end
  end
end
