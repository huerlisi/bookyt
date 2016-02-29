module Bookyt
  module Entities
    class Customer < Bookyt::Entities::Base
      expose :id
      expose :name
      expose :street
      expose :zip
      expose :city
      expose :post_office_box
      expose :extended_address
      expose :direct_debit_enabled
      expose :clearing, as: :bank_clearing_number
      expose :bank_account, as: :bank_account_number
      expose :phone_numbers, using: Bookyt::Entities::PhoneNumber

      def name
        object.vcard.full_name
      end

      def street
        object.vcard.street_address
      end

      def extended_address
        object.vcard.extended_address
      end

      def zip
        object.vcard.postal_code
      end

      def city
        object.vcard.locality
      end

      def post_office_box
        object.vcard.post_office_box
      end

      def phone_numbers
        object.vcard.contacts
      end
    end
  end
end
