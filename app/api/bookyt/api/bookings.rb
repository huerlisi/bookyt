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
          requires :credit_account_code, type: String, values: -> { Account.pluck(:code) }, desc: 'Code of the credit account'
          requires :debit_account_code, type: String,  values: -> { Account.pluck(:code) }, desc: 'Code of the debit account'
          optional :comments, type: String, desc: 'Additional comments'
          optional :invoice_id, type: Fixnum, desc: 'ID of invoice to reference', values: -> { Invoice.pluck(:id) }
        end
        post do
          begin
            credit_account = Account.find_by_code(params[:credit_account_code])
            debit_account = Account.find_by_code(params[:debit_account_code])
            attributes = {
              title: params[:title],
              amount: params[:amount],
              value_date: params[:value_date],
              credit_account: credit_account,
              debit_account: debit_account,
              comments: params[:comments],
            }
            attributes.merge!(reference: Invoice.find(params[:invoice_id])) if params[:invoice_id]
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
            requires :credit_account_code, type: String, values: -> { Account.pluck(:code) }, desc: 'Code of the credit account'
            requires :debit_account_code, type: String,  values: -> { Account.pluck(:code) }, desc: 'Code of the debit account'
            optional :comments, type: String, desc: 'Additional comments'
            optional :invoice_id, type: Fixnum, desc: 'ID of invoice to reference', values: -> { Invoice.pluck(:id) }
          end
          put do
            begin
              credit_account = Account.find_by_code(params[:credit_account_code])
              debit_account = Account.find_by_code(params[:debit_account_code])
              attributes = {
                title: params[:title],
                amount: params[:amount],
                value_date: params[:value_date],
                credit_account: credit_account,
                debit_account: debit_account,
                comments: params[:comments],
              }
              attributes.merge!(reference: Invoice.find(params[:invoice_id])) if params[:invoice_id]
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
            body false
            status 204
          end
        end
      end
    end
  end
end
