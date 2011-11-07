FactoryGirl.define do
  factory :booking_import do
    csv File.new(Rails.root + 'spec/lib/csvs/simple.csv')
  end
end