module Bookyt
  class API < Grape::API
    format :json

    helpers do
      def current_user
        User.find_by_authentication_token(env['Auth-Token'] || headers['Auth-Token'])
      end

      def current_tenant
        current_user.tenant
      end
    end

    before do
      error!({ error: 'Unauthorized' }, 401) unless current_user
    end

    before do
      @previous_locale = I18n.locale
      I18n.locale = :en
    end

    after do
      I18n.locale = @previous_locale
    end

    rescue_from ActiveRecord::RecordInvalid do |error|
      message = { 'error' => error.record.errors.full_messages }
      Rack::Response.new(message.to_json, 422)
    end

    mount Bookyt::API::Bookings
    mount Bookyt::API::Customers
    mount Bookyt::API::DebitInvoices
  end
end
