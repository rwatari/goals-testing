FactoryGirl.define do
  factory :goal do
    content { Faker::Lorem.sentence }
  end
end
