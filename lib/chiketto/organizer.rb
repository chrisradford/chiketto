module Chiketto
  class Organizer < Resource
    attr_accessor :name

    attr_attrib :description

    def self.create(params)
      response = Organizer.post 'organizer_new', params
      if response.fetch('process', false)
        response['process']['id']
      end
    end
  end
end
