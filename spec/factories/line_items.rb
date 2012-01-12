FactoryGirl.define do
  factory :line_item do
    factory :banana do
      times "1"
      quantity "x"
      price "0.99"
      title "Banana"
      description "Most delicious banana of all time!"
    end

    factory :vat do
      times "1"
      quantity "%"
      price "8"
      code "vat:full"
      title "VAT"
      description "VAT"
    end

    factory :contracting do
      times "5"
      quantity "hours"
      price "180"
      title "Contracting"
      description "Custom development by CyT! Best price for best product"
    end
  end
end
