module Bookyt
  class API < Grape::API
    format :json

    helpers do
      def current_user
        User.find_by_authentication_token(env['Auth-Token'] || headers['Auth-Token'])
      end
    end

    before do
      error!({ error: 'Unauthorized' }, 401) unless current_user
    end

    rescue_from ActiveRecord::RecordInvalid do |error|
      error = {
        'status'  => 422,
        'message' => error.record.errors.full_messages.to_sentence,
        'errors'  => error.record.errors,
      }
      Rack::Response.new(error.to_json, 422)
    end

    mount Bookyt::API::Bookings
  end
end
