FactoryGirl.define do
  factory :account_type do
    name  "account_type"
    title "Account Type"

    factory :current_assets do
      name  "current_assets"
      title "Current Assets"
    end

    factory :earnings do
      name  "earnings"
      title "Earnings"
    end

    factory :costs do
      name  "costs"
      title "Aufwand"
    end

    factory :outside_capital do
      name  "outside_capital"
      title "Fremdkapital"
    end
  end
end
