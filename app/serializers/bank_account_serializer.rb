class BankAccountSerializer < AccountSerializer
  attributes :number
  has_one :bank
end
