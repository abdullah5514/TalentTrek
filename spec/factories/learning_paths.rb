FactoryBot.define do
  factory :learning_path do
    start_date { Date.parse("2023-09-15") }
    end_date { Date.parse("2023-09-13") }
    title { "Voluptas harum occaecati doloribus." }
    # Add any other attributes specific to your LearningPath model
  end
end
