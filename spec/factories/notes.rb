FactoryGirl.define do
  Factory.sequence :content do |n|
     texts = ['bla', 'foobar', 'testing', 'no comment']
     "note #{n}: #{texts[rand(4)]}"
  end

  factory :note do
    content { Factory.next(:content) }
  end
end
