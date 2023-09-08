class CoursesLearningPath < ApplicationRecord
  belongs_to :learning_path
  belongs_to :course
  has_many :course_learning_path_details

  # Validate uniqueness of course_id within the same learning_path_id
  validates :course_id, uniqueness: { scope: :learning_path_id }, presence: true
end