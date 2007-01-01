class Balance
  attr_accessor :client
  attr_accessor :year

  def initialize(client, year = Time.now.year)
    @client = client
    @year = year
  end
end
