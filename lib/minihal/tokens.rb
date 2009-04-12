module Minihal
  module Tokens
    class Delimiter   < Minihal::Token; end
    TOKEN_BEGIN       = Delimiter.new("BEGIN")
    TOKEN_END         = Delimiter.new("END")

    class Punctuation < Minihal::Token; end
    TOKEN_PERIOD      = Punctuation.new(".")
    TOKEN_COMMA       = Punctuation.new(",")
    TOKEN_QUESTION    = Punctuation.new("?")
    TOKEN_EXCLAMATION = Punctuation.new("!")
  end

  def self.begin; Tokens::TOKEN_BEGIN end
  def self.end;   Tokens::TOKEN_END   end
end
