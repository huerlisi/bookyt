require "fastercsv"

# Excel info from: http://blog.plataformatec.com.br/2009/09/exporting-data-to-csv-and-excel-in-your-rails-app/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed:+PlataformaBlog+(Plataforma+Blog)
# Original post: http://www.brynary.com/2007/4/28/export-activerecords-to-csv

# Usage:
#   Given User is an ActiveRecord model
#
#   Options for Model.to_csv, Array.to_csv, and ActionController::Base#send_csv
#
#   :only     - Array, trumps :exclude. Only these attributes will be included instead of all attributes (things listed in :methods will still be sent)
#     :only => [ :id, :name, :created_at ]
#   :methods  - Array, additional methods to evaluate and add to the CSV response. Note: you can send nested method calls
#     :methods => [ :to_s, :complex_method, "my.method.on.a.related.object"]
#   :exclude  - Array, attributes to exclude from CSV result
#
#  From ActionController
#     send_csv User, :only => [:first_name, :email, :created_at] #This will do all records
#     send_csv User.all(:conditions => ["created_at > ?", some_date]), :only => [:first_name, :email, :created_at]
#
#  From ActiveRecord Model
#   User.to_csv :only => [ :username, :email, :created_at ], :methods => [ :age, "account.id"] # All users additionally get their related Account#id number
#   User.all(:limit => 10).to_csv :exclude => [:password, :birthdate]
#
class ActiveRecord::Base

  # Shortcut for CSV of whole table
  def self.to_csv(*args)
    find(:all).to_csv(*args)
  end

  # Get the column headers
  def self.csv_columns(options={})
    tmp_columns = if options[:only]
      options[:only] #only trumps exclude
    else
      self.content_columns.map{|curr_col| curr_col.name } - options[:exclude].map{|curr_col| curr_col.to_s }
    end

    tmp_columns + options[:methods].map{|curr_col| curr_col.to_s }
  end

  # Record to a row level csv array
  def to_csv(options={})
    self.class.csv_columns(options).map { |curr_col|
      curr_col = curr_col.to_s

      #Its a chain of method calls, on intermediary nil, just return nil
      if !curr_col.index(".")
        col_val = self.send(curr_col)
      else
        col_val = self
        curr_col.split(".").each {|curr_method| col_val = col_val.send(curr_method) unless col_val.nil?}
      end

      col_val.gsub!("\n", " ") if col_val.is_a?(String) # Strip newlines, Appease Excel Gods
      col_val
    }
  end
end


class Array

  # Convert an array of objects into a CSV String.
  def to_csv(options = {})
    column_options    = {
      :only    => options.delete(:only),
      :exclude => options.delete(:exclude) || [],
      :methods => options.delete(:methods) || []
    }

    options = {
      :col_sep => "\t" # Appease Excel Gods
    }.merge(options)

    if all? { |e| e.respond_to?(:to_csv) }
      header_row = first.class.csv_columns(column_options).to_csv

      content_rows = map { |e|
        # Get all the values of non-excluded rows
        e.to_csv(column_options)
      }.map{|r|
        # Call to_csv on the array of row-level values, this will join them into a CSV row
        r.to_csv(column_options)
      }

      ([header_row] + content_rows).join
    else
      FasterCSV.generate_line(self, options)
    end
  end

end


# module for extending ActionController
module ExcelCSVExporter
  def send_csv(kollection, options={})
    filename = options.delete(:filename) || I18n.l(Time.now, :format => :short) + ".csv"

    content = kollection.to_csv(options)

    send_data content, :filename => filename
  end
end

ActionController::Base.send :include, ExcelCSVExporter
