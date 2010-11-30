Factory.define :cash, :class => BookingTemplate do |b|
  b.title 'Bareinnahmen'
  b.credit_account_id 1
  b.debit_account_id 6
  b.code 'day:cash'
  b.matcher '[B|b]arein[z|Z]ahlung'
end

Factory.define :card_turnover, :class => BookingTemplate do |b|
  b.title 'Kreditkarten Einnahmen'
  b.credit_account_id 3
  b.debit_account_id 6
  b.code 'day:card turnover'
  b.matcher 'test'
end