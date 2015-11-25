module Bookyt
  class API
    class Bookings < Grape::API
      resource :bookings do
        desc 'Fetch all the bookings'
        get do
          bookings = Booking.all
          present bookings, with: Bookyt::Entities::Booking
        end

        desc 'Create a new booking'
        params do
          requires :title, type: String, desc: 'Title of the booking'
          requires :amount, type: BigDecimal, desc: 'Amount to be booked'
          requires :value_date, type: Date, desc: 'Date of the booking'
          requires :credit_account_tag, type: String, desc: 'Tag of the credit account'
          requires :debit_account_tag, type: String, desc: 'Tag of the debit account'
          optional :comments, type: String, desc: 'Additional comments'
        end
        post do
          begin
            credit_account = Account.find_by_tag(params[:credit_account_tag])
            debit_account = Account.find_by_tag(params[:debit_account_tag])
            attributes = {
              title: params[:title],
              amount: params[:amount],
              value_date: params[:value_date],
              credit_account: credit_account,
              debit_account: debit_account,
              comments: params[:comments],
            }
            booking = Booking.create!(attributes)
            present booking, with: Bookyt::Entities::Booking
          rescue Account::AmbiguousTag => error
            error!({ error: error.to_s }, 422)
          end
        end

        route_param :id do
          desc 'Fetch a booking'
          get do
            booking = Booking.find(params[:id])
            present booking, with: Bookyt::Entities::Booking
          end

          desc 'Update a booking'
          params do
            requires :title, type: String, desc: 'Title of the booking'
            requires :amount, type: BigDecimal, desc: 'Amount to be booked'
            requires :value_date, type: Date, desc: 'Date of the booking'
            requires :credit_account_tag, type: String, desc: 'Tag of the credit account'
            requires :debit_account_tag, type: String, desc: 'Tag of the debit account'
            optional :comments, type: String, desc: 'Additional comments'
          end
          put do
            begin
              credit_account = Account.find_by_tag(params[:credit_account_tag])
              debit_account = Account.find_by_tag(params[:debit_account_tag])
              attributes = {
                title: params[:title],
                amount: params[:amount],
                value_date: params[:value_date],
                credit_account: credit_account,
                debit_account: debit_account,
                comments: params[:comments],
              }
              booking = Booking.find(params[:id])
              booking.update_attributes!(attributes)
              present booking, with: Bookyt::Entities::Booking
            rescue Account::AmbiguousTag => error
              error!({ error: error.to_s }, 422)
            end
          end

          desc 'Delete a booking'
          delete do
            Booking.find(params[:id]).destroy
            status 204
          end
        end
      end
    end
  end
end
