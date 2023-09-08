require 'rails_helper'

RSpec.describe Talent, type: :model do
  let(:talent) { FactoryBot.create(:talent) } # Use FactoryBot or FactoryGirl for test data

  it "is valid with valid attributes" do
    expect(talent).to be_valid
  end

  it "is not valid without a name" do
    talent.name = nil
    expect(talent).to_not be_valid
  end

  it "is not valid without a roll_no" do
    talent.roll_no = nil
    expect(talent).to_not be_valid
  end

  it "is not valid without an email" do
    talent.email = nil
    expect(talent).to_not be_valid
  end

  it "is not valid with a duplicate email" do
    # Create a talent with the same email as an existing talent
    duplicate_talent = FactoryBot.build(:talent, email: talent.email)
    expect(duplicate_talent).to_not be_valid
  end

  it "has many courses" do
    expect(talent.courses).to be_empty # Assuming no courses are associated yet
  end

  it "has many learning paths" do
    expect(talent.learning_paths).to be_empty # Assuming no learning paths are associated yet
  end

  it "has many authored courses" do
    expect(talent.authored_courses).to be_empty # Assuming no authored courses yet
  end
end
