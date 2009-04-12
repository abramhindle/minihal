module Minihal
  class Network
    def initialize
      @values  = []
      @weights = Hash.new { |hash, key| hash[key] = 0 }
    end

    def [](value)
      @weights[value]
    end

    def increment(value)
      @values << value
      @weights[value] += 1
    end
    
    def next
      @values[rand(@values.length)]
    end
  end
end
