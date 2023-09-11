require 'rails_helper'

RSpec.describe Talent, type: :model do
  instructor = FactoryBot.create(:author)

  it "is valid with valid attributes" do
    talent = FactoryBot.build(:talent)
    expect(talent).to be_valid
  end

  it "is not valid without a name" do
    talent = FactoryBot.build(:talent, name: nil)
    expect(talent).not_to be_valid
  end

  it "is not valid without a roll_no" do
    talent = FactoryBot.build(:talent, roll_no: nil)
    expect(talent).not_to be_valid
  end

  it "is not valid without a valid email" do
    talent = FactoryBot.build(:talent, email: "invalid_email")
    expect(talent).not_to be_valid
  end

  it "is valid with a unique email" do
    FactoryBot.create(:talent, email: "test@example.com")
    talent = FactoryBot.build(:talent, email: "another@example.com")
    expect(talent).to be_valid
  end

  it "is not valid with a duplicate email" do
    FactoryBot.create(:talent, email: "duplicate@example.com")
    talent = FactoryBot.build(:talent, email: "duplicate@example.com")
    expect(talent).not_to be_valid
  end

  it "has many courses through courses_talents" do
    talent = FactoryBot.create(:talent)
    course1 = FactoryBot.create(:course, instructor: instructor)
    course2 = FactoryBot.create(:course, instructor: instructor)
    talent.courses << [course1, course2]

    expect(talent.courses).to include(course1, course2)
  end

  it "has many learning paths through learning_path_talents" do
    talent = FactoryBot.create(:talent)
    learning_path1 = FactoryBot.create(:learning_path)
    learning_path2 = FactoryBot.create(:learning_path)
    talent.learning_paths << [learning_path1, learning_path2]

    expect(talent.learning_paths).to include(learning_path1, learning_path2)
  end

  it "has many course learning path details" do
    talent = FactoryBot.create(:talent)
    detail1 = FactoryBot.create(:course_learning_path_detail)
    detail2 = FactoryBot.create(:course_learning_path_detail)

    talent.course_learning_path_details << [detail1, detail2]
    expect(talent.course_learning_path_details).to include(detail1, detail2)
  end

  it "has many authored courses as an instructor" do
    talent = FactoryBot.create(:talent)
    course1 = FactoryBot.create(:course, instructor: talent)
    course2 = FactoryBot.create(:course, instructor: talent)

    talent.authored_courses << [course1, course2]
    expect(talent.authored_courses).to include(course1, course2)
  end
end
