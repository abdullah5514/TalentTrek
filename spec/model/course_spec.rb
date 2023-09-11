require 'rails_helper'


RSpec.describe Course, type: :model do
  instructor = FactoryBot.create(:author)
  course = FactoryBot.create(:course, instructor: instructor)

  it "is valid with valid attributes" do
    course = FactoryBot.create(:course, instructor: instructor)
    expect(course).to be_valid
  end

  it "is not valid without a title" do
    course = FactoryBot.build(:course, title: nil)
    expect(course).to_not be_valid
  end

  it "has many talents through courses_talents" do
    course = FactoryBot.create(:course, instructor: instructor)
    talent1 = FactoryBot.create(:talent)
    talent2 = FactoryBot.create(:talent)
    course.talents << [talent1, talent2]

    expect(course.talents).to include(talent1, talent2)
  end

  it "has many learning paths through courses_learning_paths" do
    course = FactoryBot.create(:course, instructor: instructor)
    learning_path1 = FactoryBot.create(:learning_path)
    learning_path2 = FactoryBot.create(:learning_path)
    course.learning_paths << [learning_path1, learning_path2]

    expect(course.learning_paths).to include(learning_path1, learning_path2)
  end

  it "belongs to an instructor (polymorphic association)" do
    author = FactoryBot.create(:author)
    course = FactoryBot.create(:course, instructor: author)

    expect(course.instructor).to eq(author)
  end

  it "is not valid if talent is the same as the instructor" do
    talent = FactoryBot.create(:talent)
    course = FactoryBot.build(:course, instructor: talent)
    course.talents << talent

    expect(course).not_to be_valid
    expect(course.errors[:base]).to include("A course cannot have the same talent as an instructor")
  end
end
