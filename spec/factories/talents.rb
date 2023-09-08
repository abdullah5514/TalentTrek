FactoryBot.define do
    factory :talent do
      name { Faker::Name.name }
      roll_no { Faker::Number.unique.number(digits: 5) }
      email { Faker::Internet.unique.email }
      # Add any other attributes as needed
    end
  end
  