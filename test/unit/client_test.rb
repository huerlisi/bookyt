require File.dirname(__FILE__) + '/../test_helper'

class ClientTest < Test::Unit::TestCase
  fixtures :clients, :accounts

  def setup
    @bigone = clients(:noname)
    @bigone.accounts << accounts(:postfinance)
    @bigone.accounts << accounts(:ubs)
    @bigone.accounts << accounts(:empty)
  end

  def test_create
    client = Client.new(:name => "New Client")
    client.save

    assert client
    assert_equal "New Client", client.name

    noname = clients(:noname)
    assert noname
    assert_equal "No Name Yet Inc.", noname.name

    bigone = clients(:bigone)
    assert bigone
    assert_equal "Big Corp.", bigone.name
  end

  def test_add_accounts
    client = Client.new(:name => "New Client")
    client.save

    assert_equal 0, client.accounts.count

    ubs = accounts(:ubs)
    client.accounts << ubs
    assert_equal client, ubs.client

    client.accounts << accounts(:empty)
    assert_equal 2, client.accounts.count
  end

  def test_remove_accounts
    assert_equal 3, @bigone.accounts.count
    @bigone.accounts.delete(accounts(:ubs))
    assert_equal 2, @bigone.accounts.count
  end
end
