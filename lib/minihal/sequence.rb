module Minihal
  class Sequence < Array
    def self.from_sentence(sentence)
      returning new do |sequence|
        sentence.strip.split.each do |word|
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
        end
      end
    end

    def to_sentence
      sentence = reject { |word| word.is_a?(Tokens::Delimiter) }
      sentence.join(" ").sub(/[[:alpha:]]/) { |char| char.upcase }
    end
  end

  def self.string_to_sequences(string)
    string.gsub(/([.!?])(\s)/, "\\1\\1\\2").split(/(?:[.!?])\s+/).map do |sentence|
      Sequence.from_sentence(sentence)
    end
  end
end
