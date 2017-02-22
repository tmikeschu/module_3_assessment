FactoryGirl.define do
  factory :item do
    name { Faker::Book.title }
    description { Faker::HarryPotter.quote }
    image_url { Faker::Avatar.image }
  end
end
