module Bookyt
  module Entities
    class Base < Grape::Entity
      format_with(:iso_timestamp, &:iso8601)
      format_with(:float, &:to_f)
    end
  end
end
