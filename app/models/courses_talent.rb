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

   # Custom validation to check that the course's instructor is not the same as its talent
  validate :instructor_cannot_be_same_as_talent

  private

  def instructor_cannot_be_same_as_talent
    if instructor.is_a?(Talent) && talents.include?(instructor)
      errors.add(:base, "A course cannot have an instructor who is the same as its talent")
    end
  end
end
