FactoryBot.define do
  factory :course do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    course_code { Faker::Alphanumeric.alphanumeric(number: 6).upcase }
    association :instructor, factory: :author
  end
end