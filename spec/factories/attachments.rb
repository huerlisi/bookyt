FactoryGirl.define do
  factory :attachment do
    title "MyString"
    file  { File.open(File.join(Rails.root, 'spec', 'lib', 'templates', 'letter.pdf')) }
    association :reference, :factory => :employee
  end
end
