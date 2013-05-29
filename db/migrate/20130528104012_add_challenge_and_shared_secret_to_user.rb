class AddChallengeAndSharedSecretToUser < ActiveRecord::Migration
  def change
    add_column :users, :challenge, :string
    add_column :users, :shared_secret, :string
  end
end
