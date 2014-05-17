module Chiketto
  module AttrDSL

    def self.included(base)
      base.extend DSL
    end

    module DSL

      def attr_attrib(*args)
        args.collect do |value|
          define_method value.to_s do
            Chiketto::Attribute.new instance_variable_get("@#{value.to_s}")
          end
        end
      end

      def attr_date(*args)
        args.collect do |value|
          define_method value.to_s do
            date = instance_variable_get("@#{value.to_s}")
            date = date['utc'] if date.is_a?(Hash)
            DateTime.strptime date, '%FT%TZ'
          end
        end
      end

    end
  end
end
