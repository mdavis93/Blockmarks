FactoryGirl.define do
  factory :bookmark do
    sequence(:url) { |n| "http://www#{n}.google.com" }
    topic
  end
end
