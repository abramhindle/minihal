module Minihal
  class Brain
    attr_reader :values
    
    def initialize
      @values = Hash.new do |hash, key| 
        hash[key] = Network.new
      end
    end
    
    def learn(sequence)
      each_pair_in(sequence) do |left, right|
        values[left].increment(right)
      end
    end
    
    def query(value)
      returning Sequence.new do |sequence|
        while value
          sequence << value
          value = values[value].next
        end
      end
    end
    
    protected
      def each_pair_in(sequence)
        left, rest = Minihal.begin, sequence + [Minihal.end]
        rest.each do |right|
          yield left, right
          left = right
        end
      end
  end
end
