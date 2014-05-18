module Chiketto
  class Category < Resource
    attr_accessor :name,
                  :resource_uri,
                  :short_name

    def self.list
      categories = get 'categories'
      categories['categories'].map { |cat| Chiketto::Category.new cat }
    end
  end
end
