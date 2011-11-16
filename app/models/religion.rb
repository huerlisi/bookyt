class Religion < ActiveRecord::Base
  def to_s
    name.present? ? name : ''
  end
end
