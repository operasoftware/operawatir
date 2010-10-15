# encoding: utf-8
module WatirSpec
  module Runner

    module Helpers
      def browser
        @window
      end
      
      def messages
        browser.div(:id, 'messages').divs.map { |d| d.text }
      end      
    end
    
    def self.execute
      WatirSpec::Server.run!

      RSpec.configure do |config|
        config.include Helpers
        # Global variable is used because suite and all have different scope :(
        config.before(:suite) { $browser = WatirSpec.browser.obj }

        config.before(:all)   { @window = $browser.active_window }
        config.after(:all)    { @window.close }
        
        config.after(:suite)  { $browser.quit if $browser }
      end
    end

    # def add_guard_hook
    #   return if WatirSpec.unguarded?
    #   at_exit { WatirSpec::Guards.report }
    # end

  end
end
