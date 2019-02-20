class MigratePrimaryKeysToBigint < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.tables.each do |table_name|
      ActiveRecord::Base.connection.columns(table_name).each do |column|
        if (column.name.to_s.end_with?('_id') || column.name.to_s == 'id') && column.type.to_s == 'integer'
          say_with_time "Switching #{table_name}.#{column.name} from integer to bigint" do
            change_column table_name, column.name, :bigint
          end
        end
      end
    end
  end

  def down
    ActiveRecord::Base.connection.tables.each do |table_name|
      ActiveRecord::Base.connection.columns(table_name).each do |column|
        if (column.name.to_s.end_with?('_id') || column.name.to_s == 'id') && column.type.to_s == 'integer'
          change_column table_name, column.name, :int
        end
      end
    end
  end
end
