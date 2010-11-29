Factory.define :day do |day|
  day.date Date.parse('15.2.2010')
end

Factory.define :closed_day, :parent => :day do |day|
  day.cash            100.0
  day.card_turnover   50.0
  day.gross_turnover  120.0
  day.net_turnover    80.0
  day.client_count    5
  day.product_count   10
  day.expenses        20
  day.credit_turnover 10.0
  day.discount        5.0
end
