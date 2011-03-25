Factory.define :booking_template do |b|
end

Factory.define :cash, :parent => :booking_template do |b|
  b.title 'Bareinnahmen'
  b.association :credit_account, :factory => :cash_account
  b.association :debit_account, :factory => :service_account
  b.code 'day:cash'
  b.matcher '[B|b]arein[z|Z]ahlung'
end

Factory.define :card_turnover, :parent => :booking_template do |b|
  b.title 'Kreditkarten Einnahmen'
  b.association :credit_account, :factory => :eft_account
  b.association :debit_account, :factory => :service_account
  b.code 'day:card turnover'
  b.matcher 'test'
end
