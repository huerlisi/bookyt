class UnifyRemarksColumns < ActiveRecord::Migration
  def up
    # Use :text, not :string
    change_column :esr_files, :remarks, :text
    change_column :esr_records, :remarks, :text
    change_column :bookings, :comments, :text
  end

  def down
    change_column :esr_files, :remarks, :string
    change_column :esr_records, :remarks, :string
    change_column :bookings, :comments, :string
  end
end
