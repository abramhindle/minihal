module Minihal
  class Network
    def initialize
      @weights = Hash.new
    end

    def [](value)
      @weights[value]
    end

    def increment(value)
      if @weights[value]
        @weights[value] += 1
      else
        @weights[value] = 1
      end
    end
    
    def decrement(value)
      if (@weights[value] -= 1).zero?
        @weights.delete(value)
      else
        @weights[value] -= 1
      end
    end
    
    def values
      @weights.values
    end
    
    def next
      values = to_a
      values[rand(values.length)]
    end
    
    def to_a
      @weights.inject([]) do |values, (value, weight)|
        values += [value] * weight
      end
    end
  end
end
