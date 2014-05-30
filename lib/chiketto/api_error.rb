module Chiketto
  class APIError < StandardError
    def initialize(open_uri_exception)
      super(open_uri_exception.message)
    end
  end
end
