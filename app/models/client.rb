class Client < ActiveRecord::Base
  has_many :accounts

  def saldo(type)
    new_saldo = 0

    for account in accounts.send(type).all
      new_saldo += account.saldo
    end

    return new_saldo
  end
end
