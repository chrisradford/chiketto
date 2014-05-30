module Chiketto
  class Email < Resource
    attr_accessor :email,
                  :verified,
                  :primary
  end
end
