module Bookyt
  class API
    class Customers < Grape::API
      # https://github.com/huerlisi/has_vcards/blob/master/app/models/has_vcards/vcard.rb#L37
      PHONE_TYPE_MAPPING = {
        'office' => 'Tel. geschäft',
        'home' => 'Tel. privat',
        'mobile' => 'Handy',
      }

      helpers do
        def customer_params
          contacts_attributes = params[:phone_numbers].map do |phone_number|
            contacts_attributes = {
              phone_number_type: PHONE_TYPE_MAPPING[phone_number[:type]],
              number: phone_number[:number],
            }
          end
          attributes = {
            full_name: params[:name],
            extended_address: params[:extended_address],
            street_address: params[:street],
            post_office_box: params[:post_office_box],
            postal_code: params[:zip],
            locality: params[:city],
            contacts_attributes: contacts_attributes
          }
          { vcard_attributes: attributes }
        end
      end

      resource :customers do
        desc 'Fetch all the customers'
        get do
          customers = Customer.all
          present customers, with: Bookyt::Entities::Customer
        end

        desc 'Create a new customer'
        params do
          requires :name, type: String, desc: 'Name of the customer'
          requires :street, type: String, desc: 'Street of the customers address'
          requires :zip, type: String, desc: 'Zipcode of the customers address'
          requires :city, type: String, desc: 'City of the customers address'
          optional :post_office_box, type: String, desc: 'Postoffice box'
          optional :extended_address, type: String, desc: 'Extended address data'
          optional :phone_numbers, type: Array, default: [] do
            requires :type, type: String, values: %w(office home mobile)
            requires :number, type: String
          end
        end
        post do
          customer = Customer.create!(customer_params)
          present customer, with: Bookyt::Entities::Customer
        end

        route_param :id do
          desc 'Fetch a customer'
          get do
            customer = Customer.find(params[:id])
            present customer, with: Bookyt::Entities::Customer
          end

          desc 'Update a customer'
          params do
            requires :name, type: String, desc: 'Name of the customer'
            requires :street, type: String, desc: 'Street of the customers address'
            requires :zip, type: String, desc: 'Zipcode of the customers address'
            requires :city, type: String, desc: 'City of the customers address'
            optional :post_office_box, type: String, desc: 'Postoffice box'
            optional :extended_address, type: String, desc: 'Extended address data'
            optional :phone_numbers, type: Array, default: [] do
              requires :type, type: String, values: %w(office home mobile)
              requires :number, type: String
            end
          end
          put do
            customer = Customer.find(params[:id])
            customer.update_attributes!(customer_params)
            present customer, with: Bookyt::Entities::Customer
          end

          desc 'Delete a customer'
          delete do
            Customer.find(params[:id]).destroy
            status 204
          end
        end
      end
    end
  end
end
