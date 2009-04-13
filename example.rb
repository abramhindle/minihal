require 'lib/minihal'

brain = Minihal::Brain.new

Minihal.string_to_sequences(IO.read("/home/abez/.bashrc")).each { |sequence| brain.learn(sequence) }

puts brain.query.to_sentence


song = "B A G A B B B | A A A B D D | B A G A B B B | B A A B A G | B A G A B B B | A A A B D D | B A G A B B B | B A A B A G | D B A G A B B B | A A A B D D | D B A G A B B B | B A A B A G | D B A G A B B B | A A A B D D | D B A G A B B B | B A A B A G "


TOKEN_PIPE = Minihal::Tokens::Punctuation.new("|")

class MusicSequence < Minihal::Sequence
  def self.punctuation_regex_string
    "\\|"
  end
  def self.token_map(char)
    case char
    when "|" then TOKEN_PIPE
    end
  end
end

music = Minihal::Brain.new

Minihal.string_to_sequences_delegate(MusicSequence, song).each { |sequence| 
  music.learn(sequence)
}

puts music.query.infer_sequence.join

### Now with "symbols" only

symbolic_music = Minihal::Brain.new

class Note
end
class A < Note
end
class B < Note
end
class C < Note
end
class D < Note
end
class E < Note
end
class F < Note
end
class G < Note
end
class Quarter < Note
end
class Half < Note
end
class Full < Note
end


[[A, B, C, D],
 [G, A, B, Quarter],
 [B, B, Quarter, A],
 [D, A, D, Quarter],
 [F, A, G, Quarter],
 [Full],
 [Half, A, A],
 [B, B, Half],
].each { |seq| symbolic_music.learn(Minihal::Sequence.new(seq)) }


6.times {|n| puts symbolic_music.query.infer_sequence.map {|x| x.to_s }.join }
