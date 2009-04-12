module Minihal
  class Sequence < Array
    def self.from_sentence(sentence)
      sentence.strip.split.inject(new) do |sequence, word|
        word, punctuation = word.scan(/(.*?)([.,?!]*)$/).first
        sequence << word.downcase
        punctuation.split.each do |char|
          sequence << case char
            when "." then Tokens::TOKEN_PERIOD
            when "," then Tokens::TOKEN_COMMA
            when "?" then Tokens::TOKEN_QUESTION
            when "!" then Tokens::TOKEN_EXCLAMATION
          end
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

    def to_sentence
      returning [] do |sentence|
        each_pair do |left, right|
          sentence << " " if !left.is_a?(Tokens::Delimiter) && !right.is_a?(Token)
          sentence << right.to_s unless right.is_a?(Tokens::Delimiter)
        end
      end.join.capitalize
    end
  end

  def self.string_to_sequences(string)
    string.gsub(/([.!?])(\s)/, "\\1\\1\\2").split(/(?:[.!?])\s+/).map do |sentence|
      Sequence.from_sentence(sentence)
    end
  end
end
