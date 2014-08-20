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
  end
end
