class CivilStatus < ActiveRecord::Base
  def to_s
    name.present? ? name : ''
  end
end
