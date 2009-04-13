module Minihal
  class Sequence < Array
    def self.punctuation_regex_string
      ".,?!"
    end
    def self.token_map(char)
            case char
            when "." then Tokens::TOKEN_PERIOD
            when "," then Tokens::TOKEN_COMMA
            when "?" then Tokens::TOKEN_QUESTION
            when "!" then Tokens::TOKEN_EXCLAMATION
            end
    end
    def self.from_sentence(sentence)
      sentence.strip.split.inject(new) do |sequence, word|
        punc = punctuation_regex_string
        regex = Regexp.new("(.*?)([#{punc}]*)$")
        word, punctuation = word.scan(regex).first
        sequence << word.downcase
        punctuation.split.each do |char|
          sequence << token_map(char)
        end
        sequence
      end
    end

    def each_pair
      left, rest = Minihal.begin, self + [Minihal.end]
      rest.each do |right|
        yield left, right
        left = right
      end
    end

    def infer_sequence
      returning [] do |sentence|
        each_pair do |left, right|
          sentence << " " if !left.is_a?(Tokens::Delimiter) && !right.is_a?(Token)
          sentence << right.to_s unless right.is_a?(Tokens::Delimiter)
        end
      end
    end
    def to_sentence
      infer_sequence.join.capitalize
    end
  end
  def self.string_to_sequences(string)
    string_to_sequences_delegate(Sequence, string)
  end
  def self.string_to_sequences_delegate(sequence_class, string)
    string.gsub(/([.!?])(\s)/, "\\1\\1\\2").split(/(?:[.!?])\s+/).map do |sentence|
      sequence_class.from_sentence(sentence)
    end
  end
end
