module Chiketto
  class Attribute
    attr_accessor :text, :html

    def initialize(hash)
      @text = hash['text']
      @html = hash['html']
    end

    def to_s
      text
    end
  end
end
