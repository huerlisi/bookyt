module Bookyt
  class API
    class People < Grape::API
      # def self.model
      #   raise 'Must be implemented by subclass'
      # end

      # def self.entity
      #   raise 'Must be implemented by subclass'
      # end

      # def self.resource_name
      #   raise 'Must be implemented by subclass'
      # end


      def self.setup(resource_name, model, entity)
        helpers do
          def parsed_params
            PeopleParams.new(params).to_h
          end
        end

        resource resource_name do
          desc 'Fetch all the addresses'
          get do
            people = model.all
            present people, with: entity
          end

          desc 'Create a new address'
          params do
            requires :name, type: String
            requires :street, type: String
            requires :zip, type: String
            requires :city, type: String
            optional :post_office_box
            optional :extended_address
            optional :phone_numbers, type: Array, default: [] do
              requires :type, type: String, values: %w(office home mobile)
              requires :number, type: String
            end
          end
          post do
            person = model.create!(parsed_params)
            present person, with: entity
          end

          route_param :id do
            desc 'Fetch an address'
            get do
              person = model.find(params[:id])
              present person, with: entity
            end

            desc 'Update an address'
            params do
              requires :name, type: String
              requires :street, type: String
              requires :zip, type: String
              requires :city, type: String
              optional :post_office_box, type: String
              optional :extended_address, type: String
              optional :phone_numbers, type: Array, default: [] do
                requires :type, type: String, values: %w(office home mobile)
                requires :number, type: String
              end
            end
            put do
              person = model.find(params[:id])
              person.update_attributes!(parsed_params)
              present person, with: entity
            end

            desc 'Delete an address'
            delete do
              model.find(params[:id]).destroy
              status 204
            end
          end
        end
      end
    end
  end
end
