class CoursesLearningPath < ApplicationRecord
  # Associations

  # Define a many-to-one association with learning_path
  belongs_to :learning_path

  # Define a many-to-one association with course
  belongs_to :course

  # Define a one-to-many association with course_learning_path_details
  has_many :course_learning_path_details

  # Validations

  # Ensure uniqueness of course_id within the scope of learning_path_id
  validates :course_id, uniqueness: { scope: :learning_path_id }, presence: true
end
