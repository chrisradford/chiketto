module Chiketto
  class Question < Resource
    attr_accessor :type, :required, :respondent

    attr_attrib :question

    def choices
      @choices.map { |choice| Choice.new choice }
    end
  end
end
