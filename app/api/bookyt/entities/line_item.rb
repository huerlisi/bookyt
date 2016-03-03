module Bookyt
  module Entities
    class LineItem < Bookyt::Entities::Base
      expose :title
      expose :quantity
      expose :credit_account_code
      expose :debit_account_code

      with_options(format_with: :iso_timestamp) do
        expose :date
      end

      with_options(format_with: :string) do
        expose :price
        expose :total_amount
        expose :times
      end

      def credit_account_code
        object.credit_account.code
      end

      def debit_account_code
        object.debit_account.code
      end
    end
  end
end
