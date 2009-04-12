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
