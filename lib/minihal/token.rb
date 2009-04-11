module Minihal
  class Token
    def initialize(description)
      @description = description.to_s
    end
    
    def to_s
      @description
    end
    
    def inspect
      "#<#@description>"
    end
  end
end
