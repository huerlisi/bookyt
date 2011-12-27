class UseStringForSalaryDeclarationCode < ActiveRecord::Migration
  def up
    change_column :booking_templates, :salary_declaration_code, :string
  end

  def down
    change_column :booking_templates, :salary_declaration_code, :integer
  end
end
