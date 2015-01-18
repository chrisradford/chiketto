module Chiketto
  class Attribute
    attr_accessor :text, :html

    def initialize(hash = {})
      hash ||= {}
      @text = hash.fetch('text') { '' }
      @html = hash.fetch('html') { @text }
    end

    def to_s
      text
    end
  end
end
