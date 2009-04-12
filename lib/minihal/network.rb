module Minihal
  class Network
    def initialize
      @values  = []
      @weights = Hash.new
    end

    def [](value)
      @weights[value]
    end

    def increment(value)
      @values << value
      if @weights[value]
        @weights[value] += 1
      else
        @weights[value] = 1
      end
    end
    
    def next
      @values[rand(@values.length)]
    end
  end
end
