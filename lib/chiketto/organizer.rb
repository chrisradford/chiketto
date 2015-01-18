module Chiketto
  class Organizer < Resource
    attr_accessor :name

    attr_attrib :description

    def self.create(params)
      response = Organizer.post 'organizer_new', params
      if response.fetch('process', false)
        response['process']['id']
      elsif response.fetch('error', false)
        raise response['error']['error_message']
      end
    end
  end
end
