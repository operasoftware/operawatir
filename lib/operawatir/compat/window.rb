module OperaWatir
  module Compat
    module Window

      def contains_text(text)
        text.index(text)
      end

    end
  end
end
