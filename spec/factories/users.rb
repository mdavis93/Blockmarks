FactoryGirl.define do
  factory :user do
    email "myemail@me.com"
    password "helloworld"
    confirmed_at Time.now
  end
end
