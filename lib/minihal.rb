$:.unshift File.dirname(__FILE__)

require "minihal/network"
require "minihal/brain"
require "minihal/token"
require "minihal/tokens"
require "minihal/sequence"

module Kernel
  def returning(value)
    yield value
    value
  end unless defined?(returning)
end

module Minihal
  def self.begin; Tokens::TOKEN_BEGIN end
  def self.end;   Tokens::TOKEN_END   end
    
  def self.string_to_sequences(string)
    string.gsub(/([.!?])(\s)/, "\\1\\1\\2").split(/(?:[.!?])\s+/).map do |sentence|
      Sequence.from_sentence(sentence)
    end
  end
end
