FactoryBot.define do
  factory :course_learning_path_detail do
    association :talent, factory: :talent
    association :courses_learning_path
    course_position { 1 }
  end
end
