FactoryBot.define do
  factory :author do
    name { Faker::Name.name }
    speciality { Faker::Lorem.word }
    email { Faker::Internet.unique.email }
    phone { Faker::PhoneNumber.phone_number }
  end
end