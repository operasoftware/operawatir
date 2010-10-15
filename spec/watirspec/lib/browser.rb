module WatirSpec
  class Browser

    attr_accessor :name, :driver, :args
    
    def obj
      driver.new *args
    end
    
    def matches_guard?(args)
      return @guard_proc.call(args) if @guard_proc

      args.include? name
    end

    def matching_guards_in(guards)
      result = []
      guards.each { |args, data| data.each {|d| result << d } if matches_guard?(args) }
      result
    end

  end
end
