module Bookyt
  module Entities
    class Invoice < Bookyt::Entities::Base
      expose :id
      expose :title
      expose :customer_id
      expose :company_id
      expose :state
      expose :text
      expose :remarks

      expose :line_items, with: Bookyt::Entities::LineItem

      with_options(format_with: :iso_timestamp) do
        expose :value_date
        expose :due_date
        expose :duration_from
        expose :duration_to
      end
    end
  end
end
