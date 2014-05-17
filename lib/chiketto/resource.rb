require 'json'
require 'open-uri'

module Chiketto
  class Resource
    attr_reader :id

    def initialize args
      args.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

    class << self
      def get uri
        uri = endpoint uri
        resource = open uri
        JSON.parse resource.read
      end

      private

      def endpoint uri
        ENDPOINT + uri + token
      end
      
      def token
        "?token=#{ENV['EVENTBRITE_API_TOKEN']}"
      end
    end
  end
end
