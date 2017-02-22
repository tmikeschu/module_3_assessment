FactoryGirl.define do
  factory :order do
    user
    amount { Faker::Number.decimal(2) }
  end
end
