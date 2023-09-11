FactoryBot.define do
  factory :courses_learning_path do
    association :learning_path, factory: :learning_path
    association :course
  end
end
