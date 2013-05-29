module Devise
  module Models
    module Ocrable
      extend ActiveSupport::Concern

      module ClassMethods
        # ::Devise::Models.config(self, :login_code_random_pattern, :max_login_attempts)

        # Excpects the user specified by params to exist
        def generate_challenge!(params)
          email = params["user"]["email"]
          user = User.where(:email => email).first
          r = Random.new
          challenge = '%08i' % r.rand(10**8)
          user.update_column(:challenge, challenge)
          user
        end

        def find_users(params)
          email = params && params["user"] && params["user"]["email"]
          email && User.where(:email => email)
        end

        def find_user(params)
          find_users(params).first
        end
      end
    end
  end
end
