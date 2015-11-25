module Bookyt
  module Entities
    class Base < Grape::Entity
      format_with(:iso_timestamp) do |dt|
        dt ? dt.iso8601 : nil
      end
      format_with(:string, &:to_s)
    end
  end
end
