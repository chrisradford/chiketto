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
      uri = endpoint(uri) + build_query_string(params)
      resource = open uri
      JSON.parse resource.read
    rescue OpenURI::HTTPError => e
      raise e unless e.message =~ /^404/
    end

    def self.post(uri, params = {})
      uri = URI.parse endpoint(uri) + build_query_string(params)
      resource = open_post uri
      JSON.parse resource
    end

    def self.endpoint(uri)
      ENDPOINT + uri + token
    end

    def self.open_post(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request.add_field 'Authorization', "Bearer #{Chiketto.api_key}"
      response = http.request(request)
      if response.code !~ /20\d/
        raise Chiketto::Exception, JSON.parse(response.body)
      end
      response.body
    end

    def self.build_query_string(params)
      query_params = ''
      stack = []

      params.each do |k, v|
        if v.is_a?(Hash)
          stack << [k, v]
        else
          query_params << "#{k}=#{CGI::escape(v)}&"
        end
      end

      stack.each do |parent, hash|
        hash.each do |k, v|
          if v.is_a?(Hash)
            stack << ["#{parent}[#{k}]", v]
          else
            query_params << "#{parent}[#{k}]=#{CGI::escape(v)}&"
          end
        end
      end

      query_params.chop!
      "&#{query_params}"
    end

    def self.token
      "/?token=#{Chiketto.api_key}"
    end

    def self.should_paginate(pagination)
      pagination['page_count'] > pagination['page_number']
    end

    def self.paginated(resource, id, params)
      page = 0
      resources = []
      loop do
        page += 1
        response = self.send("find_#{resource}", id, params.merge(page: page.to_s))
        resources.concat response[resource.to_s]
        break unless should_paginate(response['pagination'])
      end
      resources
    end
  end
end
