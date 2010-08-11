require 'test_helper'

class BalanceTest < ActiveSupport::TestCase
  fixtures :clients

  def setup
    @client = clients(:noname)
    @balance = Balance.new(@client, 2000)
  end

  def test_create
    balance = Balance.new(@client)

    assert balance
    assert_equal @client, balance.client
    assert_equal Time.now.year, balance.year
  end

  def test_create_last_year
    balance = Balance.new(@client, 3000)

    assert balance
    assert_equal 3000, balance.year
  end

end
