module Bookyt
  module Entities
    class DebitDirectFile < Bookyt::Entities::Base
      expose :id
      expose :title
      expose :content

      def title
        object.to_s
      end
    end
  end
end
