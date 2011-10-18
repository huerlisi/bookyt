class Note < ActiveRecord::Base
  belongs_to :note_of_sth, :polymorphic => true
  belongs_to :user

  def to_s
    "#{user}:#{created_at}"
  end
end
