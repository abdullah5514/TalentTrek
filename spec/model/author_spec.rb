# spec/models/author_spec.rb

require 'rails_helper'

RSpec.describe Author, type: :model do
  describe "Validations" do
    it "is valid with valid attributes" do
      author = FactoryBot.build(:author)
      expect(author).to be_valid
    end

    it "is not valid without a name" do
      author = FactoryBot.build(:author, name: nil)
      expect(author).not_to be_valid
      expect(author.errors[:name]).to include("can't be blank")
    end

    it "is not valid without a speciality" do
      author = FactoryBot.build(:author, speciality: nil)
      expect(author).not_to be_valid
      expect(author.errors[:speciality]).to include("can't be blank")
    end

    it "is not valid without a unique email" do
      existing_author = FactoryBot.create(:author, email: "test@example.com")
      author = FactoryBot.build(:author, email: "test@example.com")
      expect(author).not_to be_valid
      expect(author.errors[:email]).to include("has already been taken")
    end

    it "is valid with a unique email" do
      FactoryBot.create(:author, email: "test@example.com")
      author = FactoryBot.build(:author, email: "unique@example.com")
      expect(author).to be_valid
    end
  end

  describe "before_destroy callback" do
    it "transfers courses to another author with the same speciality" do
      author1 = FactoryBot.create(:author, speciality: "Math")
      author2 = FactoryBot.create(:author, speciality: "Math")
      course = FactoryBot.create(:course, instructor: author1)
      author1.destroy
      course.reload
      expect(course.instructor).to eq(author2)
    end


  end
end
