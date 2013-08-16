FactoryGirl.define do
  factory :day do
    date Date.parse('15.2.2010')

    factory :closed_day do
      cash            100.0
      card_turnover   50.0
      gross_turnover  120.0
      net_turnover    80.0
      client_count    5
      product_count   10
      expenses        20
      credit_turnover 10.0
      discount        5.0
    end
  end
end
