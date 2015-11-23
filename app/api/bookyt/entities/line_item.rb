module Bookyt
  module Entities
    class LineItem < Bookyt::Entities::Base
      expose :title
      expose :quantity
      expose :credit_account_id
      expose :debit_account_id

      with_options(format_with: :iso_timestamp) do
        expose :date
      end

      with_options(format_with: :float) do
        expose :price
        expose :total_amount
        expose :times
      end
    end
  end
end
