module OperaWatir
  module Compat
    module Collection

      # TODO Refactor: This is a big hack. For some reason when you define the []
      # method, it doesn't get called.
      def self.included(klass)
        klass.send(:define_method, :[]) do |index|
          elements[index - 1]
        end
      end

      def [](index)
        puts 'I never get called :('
        super(index -1)
      end

      def self.def_responder(*methods)
        methods.each do |method|
          define_method method.to_sym do
            method_missing method.to_sym # LOL, Watirspec
          end
        end
      end

      def_responder :name

    end
  end
end
