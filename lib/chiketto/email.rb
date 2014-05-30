module Chiketto
  class Email < Resource
    attr_accessor :email,
                  :verified,
                  :primary

    def to_s
      @email
    end
  end
end
