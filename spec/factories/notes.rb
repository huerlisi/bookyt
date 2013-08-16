FactoryGirl.define do
  sequence :content do |n|
     texts = ['bla', 'foobar', 'testing', 'no comment']
     "note #{n}: #{texts[rand(4)]}"
  end

  factory :note do
    content { generate(:content) }
  end
end
