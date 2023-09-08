# spec/models/learning_path_spec.rb

require 'rails_helper'

instructor = FactoryBot.create(:author)



RSpec.describe LearningPath, type: :model do
  # Validation tests
  it "is valid with valid attributes" do
    learning_path = FactoryBot.create(:learning_path) # Use create to persist it
    expect(learning_path).to be_valid
  end

  it "is not valid without a title" do
    learning_path = FactoryBot.build(:learning_path, title: nil)
    expect(learning_path).not_to be_valid
  end

  # Additional custom test cases
  it "can be associated with multiple talents" do
    learning_path = FactoryBot.create(:learning_path)
    talents = FactoryBot.create_list(:talent, 3)

    learning_path.talents << talents

    expect(learning_path.talents.count).to eq(3)
  end

  it "can be associated with multiple courses" do
    learning_path = FactoryBot.create(:learning_path)
    # Create multiple courses and associate them with the same instructor
    courses = FactoryBot.create_list(:course, 3, instructor: instructor)

    learning_path.courses << courses

    expect(learning_path.courses.count).to eq(3)
  end

end
