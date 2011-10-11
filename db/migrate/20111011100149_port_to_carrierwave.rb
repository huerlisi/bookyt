class PortToCarrierwave < ActiveRecord::Migration
  def up
    rename_column :esr_files, :filename, :file
    remove_column :esr_files, :content_type
    remove_column :esr_files, :size
  end
  
  def down
    add_column :esr_files, :size, :integer
    add_column :esr_files, :content_type, :string
    rename_column :esr_files, :file, :filename
  end
end
