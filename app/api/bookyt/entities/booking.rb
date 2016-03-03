module Bookyt
  module Entities
    class Booking < Bookyt::Entities::Base
      expose :id
      expose :title
      expose :credit_account_code
      expose :debit_account_code
      expose :comments

      with_options(format_with: :iso_timestamp) do
        expose :value_date
      end

      with_options(format_with: :string) do
        expose :amount
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
