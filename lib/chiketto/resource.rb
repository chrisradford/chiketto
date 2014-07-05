require 'json'
require 'open-uri'
require 'net/http'

module Chiketto
  class Resource
    include Chiketto::AttrDSL

    attr_reader :id

    def initialize(args = {})
      args.each do |k, v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

    def self.get(uri, params = {})
      uri = endpoint(uri) + query(params)
      resource = open uri
      JSON.parse resource.read
    end

    def self.post(uri, params = {})
      uri = URI.parse legacy_endpoint(uri) + query(params)
      resource = open_post uri
      JSON.parse resource
    end

    def self.endpoint(uri)
      ENDPOINT + uri + token
    end

    def self.legacy_endpoint(uri)
      LEGACY_ENDPOINT + uri + "?"
    end

    def self.open_post(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request.add_field 'Authorization', "Bearer #{Chiketto.api_key}"
      http.request(request).body
    end

    def self.query(params)
      params.to_params
    end

    def self.token
      "/?token=#{Chiketto.api_key}"
    end
  end
end
