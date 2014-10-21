module Chiketto
  class AttendeeProfile < Resource
    attr_accessor :first_name,
                  :last_name,
                  :email,
                  :name,
                  :prefix,
                  :suffix,
                  :age,
                  :job_title,
                  :company,
                  :website,
                  :blog,
                  :gender,
                  :birth_date,
                  :cell_phone

    def addresses
      @addresses.to_h.inject({}) do |hash, (key, address)|
        hash.merge(key.to_sym => Address.new(address.to_h))
      end
    end
  end
end
