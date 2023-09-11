class LearningPath < ApplicationRecord
  # Associations

  # Define a many-to-many association with learning_path_talents through learning_path_talents
  has_many :learning_path_talents
  has_many :talents, through: :learning_path_talents

  # Define a many-to-many association with courses_learning_paths through courses_learning_paths
  has_many :courses_learning_paths, dependent: :destroy
  has_many :courses, through: :courses_learning_paths

  # Define a many-to-many association with course_learning_path_details through courses_learning_paths
  has_many :course_learning_path_details, through: :courses_learning_paths

  validates :title, presence: true
end
