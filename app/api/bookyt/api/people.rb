module Bookyt
  class API
    class People < Grape::API
      def self.setup_index(model, entity)
        desc 'Fetch all the addresses'
        get do
          people = model.all
          present people, with: entity
        end
      end

      def self.setup_create(model, entity)
        desc 'Create a new address'
        setup_attribute_params
        post do
          person = model.create!(parsed_params)
          present person, with: entity
        end
      end

      def self.setup_show(model, entity)
        desc 'Fetch an address'
        get do
          person = model.find(params[:id])
          present person, with: entity
        end
      end

      def self.setup_update(model, entity)
        desc 'Update an address'
        setup_attribute_params
        put do
          person = model.find(params[:id])
          person.update_attributes!(parsed_params)
          present person, with: entity
        end
      end

      def self.setup_delete(model)
        desc 'Delete an address'
        delete do
          model.find(params[:id]).destroy
          status 204
        end
      end

      def self.setup_attribute_params
        params do
          requires :name, type: String
          requires :street, type: String
          requires :zip, type: String
          requires :city, type: String
          optional :post_office_box, type: String
          optional :extended_address, type: String
          optional :direct_debit_enabled, type: Boolean
          optional :bank_clearing_number, type: String
          optional :bank_account_number, type: String
          optional :phone_numbers, type: Array, default: [] do
            requires :type, type: String, values: %w(office home mobile)
            requires :number, type: String
          end
        end
      end

      def self.setup(resource_name, model, entity)
        helpers do
          def parsed_params
            PeopleParams.new(params).to_h
          end
        end

        resource resource_name do
          setup_index model, entity
          setup_create model, entity

          route_param :id do
            setup_show model, entity
            setup_update model, entity
            setup_delete model
          end
        end
      end
    end
  end
end
