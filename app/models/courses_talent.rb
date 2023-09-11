class CoursesTalent < ApplicationRecord
  # Include the Status module from CoursesTalents namespace
  include CoursesTalents::Status

  # Associations

  # Define a many-to-one association with talent
  belongs_to :talent

  # Define a many-to-one association with course
  belongs_to :course

  # Validations

  # Ensure uniqueness of talent_id within the scope of course_id
  validates :talent_id, uniqueness: { scope: :course_id }
end
