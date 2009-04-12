module Minihal
  class Brain
    attr_reader :network
    
    def initialize
      @network = Hash.new { |hash, key| hash[key] = Network.new }
    end
    
    def learn(sequence)
      sequence.each_pair do |left, right|
        network[left].increment(right)
      end
    end
    
    def query(value = Minihal.begin)
      returning Sequence.new([value]) do |sequence|
        sequence << value while value = network[value].next
      end
    end
  end
end
