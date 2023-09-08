require 'rails_helper'

instructor = FactoryBot.create(:author)
course = FactoryBot.create(:course, instructor: instructor)

RSpec.describe Course, type: :model do
  it "is valid with valid attributes" do
    course = FactoryBot.create(:course, instructor: instructor)
    expect(course).to be_valid
  end

  it "is not valid without a title" do
    course = FactoryBot.build(:course, title: nil)
    expect(course).to_not be_valid
  end

  it "is not valid without an author (instructor)" do
    course = FactoryBot.build(:course, instructor: nil)
    expect(course).to_not be_valid
  end

  it "has many talents" do
    course = FactoryBot.create(:course, instructor: instructor)
    talent1 = FactoryBot.create(:talent)
    talent2 = FactoryBot.create(:talent)

    course.talents << [talent1, talent2]

    expect(course.talents.count).to eq(2)
  end

  it "belongs to an instructor (polymorphic association)" do
    instructor = FactoryBot.create(:author)
    course = FactoryBot.create(:course, instructor: instructor)

    expect(course.instructor).to eq(instructor)
  end
end
