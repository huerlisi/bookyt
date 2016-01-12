# encoding: UTF-8

module Bookyt
  class API
    class Customers < Grape::API

      helpers do
        def customer_params
          CustomerParams.new(params).to_h
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
