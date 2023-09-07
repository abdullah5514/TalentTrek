class CoursesTalent < ApplicationRecord
  include CoursesTalents::Status
   # Validation for talent_id to ensure it's unique for each course
  validates :talent_id, presence: true, uniqueness: true
end
