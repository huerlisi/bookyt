class Sqlite3Extension
  def self.setup(connection)
    @connection = connection
    regexp
    year
  end

  def self.regexp
    @connection.create_function("regexp", 2) do |func, expr, value|
      begin
        if value.to_s && value.to_s.match(Regexp.new(expr.to_s))
          func.result = 1
        else
          func.result = 0
        end
      rescue => e
        puts "error: #{e}"
      end
    end
  end

  def self.year
    @connection.create_function("year", 1) do |func, date|
      begin
        func.result = Date.parse(date).year
      rescue => e
        puts "error: #{e}"
      end
    end
  end
end

require 'active_record/connection_adapters/abstract/connection_pool'
class ActiveRecord::ConnectionAdapters::ConnectionPool
  alias orig_connection connection
  def connection
    conn = orig_connection

    if conn.adapter_name.eql?("SQLite")
      Sqlite3Extension.setup(conn.instance_variable_get(:@connection))
    end

    return conn
  end
end
