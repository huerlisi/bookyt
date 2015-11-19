module Bookyt
  class API
    class Bookings < Grape::API
      resource :bookings do
        desc 'Create a new booking'
        params do
          requires :title, type: String, desc: 'Title of the booking'
          requires :amount, type: Float, desc: 'Amount to be booked'
          requires :value_date, type: Date, desc: 'Date of the booking'
          requires :credit_account_tag, type: String, desc: 'Tag of the credit account'
          requires :debit_account_tag, type: String, desc: 'Tag of the debit account'
          optional :comments, type: String, desc: 'Additional comments'
        end
        post do
          credit_account = Account.tagged_with(params[:credit_account_tag]).first
          debit_account = Account.tagged_with(params[:debit_account_tag]).first
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
        end
      end
    end
  end
end
